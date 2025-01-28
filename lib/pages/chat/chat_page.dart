import 'dart:io';

import 'package:chat_app/models/message.dart';
import 'package:chat_app/pages/chat/chat_message_widget.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _inputCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<ChatMessageWidget> msgs = [];
  bool onWriting = false;
  late ChatService chatService;
  late SocketService socketService;
  late AuthProvider auth;

  @override
  void initState() {
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    auth = Provider.of<AuthProvider>(context, listen: false);
    socketService.socket.on('p-msg', _listenMsg);
    _getMessages();
    super.initState();
  }

  _listenMsg(payload) {
    final newMsg = ChatMessageWidget(
      uid: payload['from'],
      text: payload['message'],
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 400)),
    );
    setState(() {
      msgs.insert(0, newMsg);
    });
    newMsg.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final user = chatService.userTo;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemCount: msgs.length,
                itemBuilder: (_, i) => msgs[i],
              ),
            ),
            const Divider(height: 1),
            Container(
              color: Colors.white,
              child: SafeArea(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          focusNode: _focusNode,
                          controller: _inputCtrl,
                          onSubmitted: _handleSubmit,
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              setState(() {
                                onWriting = true;
                              });
                              return;
                            }
                            setState(() {
                              onWriting = false;
                            });
                          },
                          decoration: InputDecoration.collapsed(
                            hintText: 'Speak with ${user.name}',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Platform.isIOS
                            ? CupertinoButton(
                                borderRadius: BorderRadius.circular(20),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                color: Colors.blue[400],
                                disabledColor: Colors.grey,
                                onPressed: onWriting ? () => _handleSubmit(_inputCtrl.text.trim()) : null,
                                child: const Text(
                                  'Send',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                child: IconTheme(
                                  data: IconThemeData(color: Colors.blue[400]),
                                  child: IconButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    icon: const Icon(Icons.send),
                                    onPressed: onWriting ? () => _handleSubmit(_inputCtrl.text.trim()) : null,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    final user = chatService.userTo;
    return AppBar(
      toolbarHeight: 80,
      elevation: 1,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blueAccent,
            child: Text(
              user.name.substring(0, 3),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            user.name,
            style: const TextStyle(color: Colors.black87, fontSize: 12),
          )
        ],
      ),
    );
  }

  void _handleSubmit(String value) {
    _inputCtrl.clear();
    _focusNode.requestFocus();
    if (value.trim().isNotEmpty) {
      final newMsg = ChatMessageWidget(
        uid: auth.user!.uid,
        text: value,
        animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 400)),
      );
      msgs.insert(0, newMsg);
      newMsg.animationController.forward();
      setState(() {
        onWriting = false;
      });
      socketService.emit('p-msg', {
        'from': auth.user?.uid,
        'to': chatService.userTo.uid,
        'message': value,
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (ChatMessageWidget msg in msgs) {
      msg.animationController.dispose();
    }
    socketService.socket.off('p-msg');
    super.dispose();
  }

  Future<void> _getMessages() async {
    await chatService.getMessagesForChat(chatService.userTo.uid);
    List<Message> chatMessages = chatService.messages;
    final history = chatMessages.map((m) => ChatMessageWidget(
          uid: m.from,
          text: m.message,
          animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 0))..forward(),
        ));
    setState(() {
      msgs.insertAll(0, history);
    });
  }
}
