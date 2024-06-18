import 'package:firebase_auth_crud_social_media_app/components/app_drawer.dart';
import 'package:firebase_auth_crud_social_media_app/repository/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userData =
        RepositoryProvider.of<UsersRepository>(context).getCurrentUserData();

    return Scaffold(
      drawer: const AppDrawer(selectedIndex: 1),
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(userData['name']!),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(userData['email']!),
          ),
        ],
      ),
    );
  }
}
