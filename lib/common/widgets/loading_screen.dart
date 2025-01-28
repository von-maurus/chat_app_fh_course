import 'package:chat_app/pages/login/login_page.dart';
import 'package:chat_app/pages/users/users_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 5,
              semanticsLabel: 'Loading...',
            ),
          );
        },
      ),
    );
  }

  _checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    final socket = Provider.of<SocketService>(context, listen: false);
    final isLoggedIn = await authService.isLoggedIn();
    if (context.mounted) {
      if (isLoggedIn) {
        await socket.connect();
        return Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const UsersPage(),
            transitionDuration: const Duration(milliseconds: 1000),
          ),
        );
      }
      return Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginPage(),
          transitionDuration: const Duration(milliseconds: 2000),
        ),
      );
    }
  }
}
