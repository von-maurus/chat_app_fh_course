import 'dart:convert';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/users_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsersService {
  // create a getUsers method that returns a list of users
  Future<UserResponse> getUsers() async {
    try {
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/users'), headers: {
        'Content-Type': 'application/json',
        'Authorization': await AuthProvider().getToken() ?? '',
      });
      if (resp.statusCode != 200) {
        return UserResponse(ok: false, msg: 'Error: ${resp.body}');
      }
      return UserResponse.fromJson(jsonDecode(resp.body));
    } catch (e) {
      return UserResponse(ok: false, msg: e.toString());
    }
  }
}
