import 'package:firebase_auth_crud_social_media_app/components/app_drawer.dart';
import 'package:firebase_auth_crud_social_media_app/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              tooltip: "Logout",
              onPressed: context.read<FirebaseAuthService>().signOut,
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
