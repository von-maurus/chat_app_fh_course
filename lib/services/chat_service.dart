import 'dart:convert';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/message.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  List<Message> _messages = [];
  List<Message> get messages => _messages;
  late User userTo;

  // void sendMessage(String content, String senderId, String receiverId) {
  //   final message = Message(
  //     content: content,
  //     senderId: senderId,
  //     receiverId: receiverId,
  //     timestamp: DateTime.now(),
  //   );
  //   _messages.add(message);
  //   notifyListeners();
  // }

  void deleteMessage(Message message) {
    _messages.remove(message);
    notifyListeners();
  }

  Future<void> getMessagesForChat(String from) async {
    final resp = await http.get(Uri.parse("${Environment.apiUrl}/messages/$from"), headers: {
      'Content-Type': 'application/json',
      'Authorization': await AuthProvider().getToken() ?? '',
    });
    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      final msgs = decodedData["messages"] as List;
      _messages = msgs.map((data) => Message.fromJson(data)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
