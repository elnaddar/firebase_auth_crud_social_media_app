import 'package:firebase_auth_crud_social_media_app/components/app_drawer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(selectedIndex: 1),
      appBar: AppBar(
        title: const Text("Profile"),
      ),
    );
  }
}
