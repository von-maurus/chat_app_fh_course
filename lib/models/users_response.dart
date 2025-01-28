import 'package:chat_app/models/user.dart';

class UserResponse {
  bool ok;
  List<User>? users;
  String? msg;

  UserResponse({this.ok = false, this.users, this.msg});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      ok: json['ok'],
      users: json['users'] != null ? (json['users'] as List).map((i) => User.fromJson(i)).toList() : null,
      msg: json['msg'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ok': ok,
      'users': users?.map((i) => i.toJson()).toList(),
      'msg': msg,
    };
  }
}
