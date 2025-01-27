import 'dart:convert';
import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  bool _isAuthenticating = false;
  String? get token => _token;
  bool get isAuthenticating => _isAuthenticating;
  User? user;
  final _storage = const FlutterSecureStorage();

  set authenticating(bool value) {
    _isAuthenticating = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'jwt');
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    return await storage.delete(key: 'jwt');
  }

  Future<bool> login(String email, String password) async {
    authenticating = true;
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      user = loginResponse.user;
      // Save token
      _saveToken(loginResponse.token);
      authenticating = false;
      return true;
    }
    authenticating = false;
    return false;
  }

  Future<void> logout() async {
    user = null;
    _token = null;
    await _removeToken();
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    _token = await _getToken();
    if (_token == null) return false;

    final response = await http.get(
      Uri.parse('${Environment.apiUrl}/login/refresh'),
      headers: {'Content-Type': 'application/json', 'Authorization': '$_token'},
    );
    return response.statusCode == 200;
  }

  Future<void> _saveToken(String token) async {
    _token = token;
    return await _storage.write(key: 'jwt', value: token);
  }

  Future<void> _removeToken() async {
    return await _storage.delete(key: 'jwt');
  }

  Future<String?> _getToken() async {
    return _storage.read(key: 'jwt');
  }

  Future<dynamic> register(String name, String email, String password) async {
    authenticating = true;
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}/login/new'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      user = loginResponse.user;
      // Save token
      _saveToken(loginResponse.token);
      authenticating = false;
      return true;
    }
    authenticating = false;
    final error = jsonDecode(response.body);
    return error['msg'] ?? 'Please check your information. If you are already registered, please log in.';
  }
}
