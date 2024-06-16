import 'package:firebase_auth_crud_social_media_app/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text("Home Page"),
            FilledButton(
              onPressed: () => Navigator.of(context).pushNamed("/register"),
              child: const Text("go to reg"),
            ),
            FilledButton(
              onPressed: () => context.read<FirebaseAuthService>().signOut(),
              child: const Text("log out"),
            )
          ],
        ),
      ),
    );
  }
}
