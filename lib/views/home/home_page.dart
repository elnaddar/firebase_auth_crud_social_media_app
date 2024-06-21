import 'package:firebase_auth_crud_social_media_app/components/app_drawer.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:firebase_auth_crud_social_media_app/repository/users_repository.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/posts/write_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usersRepo = RepositoryProvider.of<UsersRepository>(context);
    final posts = PostsRepository(
        usersRepo: usersRepo, firestoreService: usersRepo.storeService);

    return RepositoryProvider.value(
      value: posts,
      child: Scaffold(
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
        body: CustomScrollView(slivers: [
          const SliverToBoxAdapter(child: WritePostWidget()),
          StreamBuilder(
            stream: posts
                .getPosts()
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("Something went wrong try again."),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator.adaptive()));
              }
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const SliverToBoxAdapter(
                    child: Center(child: Text("No posts till now.")));
              }
              final items = snapshot.data!.docs;
              return SliverList.builder(
                itemBuilder: (context, index) {
                  final data = items[index].data();
                  return ListTile(title: Text(data['content']));
                },
                itemCount: items.length,
              );
            },
          )
        ]),
      ),
    );
  }
}
