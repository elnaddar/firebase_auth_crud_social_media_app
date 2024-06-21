import 'package:firebase_auth_crud_social_media_app/components/app_drawer.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/posts/write_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              onPressed: () => context.go("/logout"),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const WritePostWidget(),
    );
  }
}
