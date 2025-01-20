import 'dart:io';

import 'package:chat_app/pages/chat/chat_message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
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
                            hintText: 'Habla con Mariave',
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
    return AppBar(
      elevation: 1,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: const Column(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.blueAccent,
            child: Text(
              'Te',
              style: TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(height: 3),
          Text(
            'Mariave Díaz',
            style: TextStyle(color: Colors.black87, fontSize: 12),
          )
        ],
      ),
    );
  }

  void _handleSubmit(String value) {
    print(value);
    _inputCtrl.clear();
    _focusNode.requestFocus();
    if (value.trim().isNotEmpty) {
      final newMsg = ChatMessageWidget(
        uid: '123',
        text: value,
        animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 400)),
      );
      msgs.insert(0, newMsg);
      newMsg.animationController.forward();
      setState(() {
        onWriting = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (ChatMessageWidget msg in msgs) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
}
