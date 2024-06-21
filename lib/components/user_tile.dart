import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});
  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: user['photoURL'] != null
            ? Image.network(user['photoURL'])
            : const Icon(Icons.person),
      ),
      title: Text(user['name']),
      subtitle: Text("@${user['email'].toString().split("@")[0]}"),
      subtitleTextStyle: TextStyle(color: Colors.grey.shade500),
    );
  }
}
