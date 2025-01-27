import 'package:chat_app/models/user.dart';

class LoginResponse {
  final bool ok;
  final User? user;
  final String token;

  LoginResponse({
    required this.ok,
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      ok: json['ok'],
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ok': ok,
      'user': user?.toJson() ?? '',
      'token': token,
    };
  }
}
