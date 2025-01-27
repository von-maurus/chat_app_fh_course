import 'package:chat_app/common/utils/show_custom_dialog.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/pages/login/login_page.dart';
import 'package:chat_app/pages/users/user_list_tile.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final users = [
    User(uid: '1', name: 'Mariave', email: 'mariave@love.com', online: true),
    User(uid: '1', name: 'Ely', email: 'ely@love.com', online: true),
    User(uid: '1', name: 'Hector', email: 'hector@love.com', online: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: _refreshUsers,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: users.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final user = users[index];
            return UserListTile(user: user);
          },
        ),
      ),
    );
  }

  Future<void> _refreshUsers() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  AppBar _buildAppBar() {
    final authService = Provider.of<AuthProvider>(context, listen: true);
    return AppBar(
      title: Text(
        authService.user?.name ?? '',
        style: const TextStyle(color: Colors.black87),
      ),
      elevation: 1,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          showCustomDialog(
            context,
            title: 'Goodbye',
            subtitle: 'Are you sure you want to logout?',
            onPressed: () async {
              await authService.logout();
              if (context.mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
              }
            },
          );
        },
        icon: const Icon(
          Icons.exit_to_app_rounded,
          color: Colors.black87,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: const Icon(Icons.check_circle, color: Colors.green),
        )
      ],
    );
  }
}
