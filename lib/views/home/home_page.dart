import 'package:firebase_auth_crud_social_media_app/components/app_drawer.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:firebase_auth_crud_social_media_app/repository/users_repository.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/posts/posts_builder/posts_builder.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/posts/write_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usersRepo = RepositoryProvider.of<UsersRepository>(context);

    return RepositoryProvider(
      create: (BuildContext context) => PostsRepository(
          usersRepo: usersRepo, firestoreService: usersRepo.storeService),
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text("Wall"),
        ),
        body: const CustomScrollView(slivers: [
          SliverToBoxAdapter(child: WritePostWidget()),
          SliverToBoxAdapter(child: SizedBox(height: 6)),
          PostsBuilder(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
        ]),
      ),
    );
  }
}
