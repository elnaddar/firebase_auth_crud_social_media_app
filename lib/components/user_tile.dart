import 'package:firebase_auth_crud_social_media_app/components/app_cache_net_image.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});
  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CircleAvatar(
          child: user['photoURL'] != null
              ? AppCacheNetImage(imageUrl: user['photoURL'])
              : const Icon(Icons.person),
        ),
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
