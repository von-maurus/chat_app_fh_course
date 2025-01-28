import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    return ListTile(
      leading: CircleAvatar(child: Text(user.name.substring(0, 3))),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Icon(
        user.online ? Icons.circle : Icons.circle_outlined,
        color: user.online ? Colors.green : Colors.red,
      ),
      onTap: () {
        chatService.userTo = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }
}
