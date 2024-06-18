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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(25),
              child: const Icon(Icons.person, size: 64),
            ),
            const SizedBox(height: 25),
            Text(
              userData['name']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              userData['email']!,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
