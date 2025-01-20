import 'package:flutter/material.dart';
import 'package:chat_app/common/widgets/loading_screen.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/login/login_page.dart';
import 'package:chat_app/pages/register/register_page.dart';
import 'package:chat_app/pages/users/users_page.dart';

final Map<String, WidgetBuilder> routes = {
  'chat': (_) => const ChatPage(),
  'users': (_) => const UsersPage(),
  'login': (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'loading': (_) => const LoadingScreen(),
};
