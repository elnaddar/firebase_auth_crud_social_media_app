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

class UserTileShimmer extends StatelessWidget {
  const UserTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(),
      title: SizedBox(
        height: 16,
        width: 100,
        child: ColoredBox(color: Colors.black),
      ),
      subtitle: SizedBox(
        height: 12,
        width: 50,
        child: ColoredBox(color: Colors.black),
      ),
    );
  }
}
