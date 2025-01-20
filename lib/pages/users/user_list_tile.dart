import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(user.name.substring(0, 3))),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Icon(
        user.online ? Icons.circle : Icons.circle_outlined,
        color: user.online ? Colors.green : Colors.red,
      ),
      onTap: () {},
    );
  }
}
