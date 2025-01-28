import 'package:chat_app/global/environment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:chat_app/models/server_states.dart';

class SocketService with ChangeNotifier {
  static final _baseUrl = Environment.socketUrl;
  ServerStates _serverStates = ServerStates.connecting;
  late IO.Socket _socket;
  ServerStates get serverStates => _serverStates;
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  Future<void> connect() async {
    final token = await AuthProvider().getToken();

    _socket = IO.io(_baseUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {"x-token": token},
    });
    // Dart client
    _socket.on('connect', (_) {
      _serverStates = ServerStates.online;
      notifyListeners();
    });

    _socket.on('reply', (data) {
      print('Incoming reply from server: $data');
    });

    _socket.on('disconnect', (_) {
      _serverStates = ServerStates.offline;
      notifyListeners();
    });

    _socket.on('connect_error', (error) {
      _serverStates = ServerStates.offline;
      notifyListeners();
      print('Connection Error: $error');
    });

    _socket.on('connect_timeout', (_) {
      _serverStates = ServerStates.offline;
      notifyListeners();
      print('Connection Timeout');
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
