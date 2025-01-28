import 'package:chat_app/common/utils/show_custom_dialog.dart';
import 'package:chat_app/models/server_states.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/pages/login/login_page.dart';
import 'package:chat_app/pages/users/user_list_tile.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usersService = UsersService();
  List<User> users = [];

  @override
  void initState() {
    _refreshUsers();
    super.initState();
  }

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
    final resp = await usersService.getUsers();
    if (resp.ok) {
      setState(() {
        users = resp.users!;
      });
    }
  }

  AppBar _buildAppBar() {
    final authService = Provider.of<AuthProvider>(context, listen: true);
    final socket = Provider.of<SocketService>(context, listen: true);
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
              socket.disconnect();
              await authService.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
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
          child: socket.serverStates == ServerStates.online
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.offline_bolt_outlined, color: Colors.red),
        )
      ],
    );
  }
}
