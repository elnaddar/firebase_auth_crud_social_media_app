import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/posts/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsBuilder extends StatelessWidget {
  const PostsBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final posts = RepositoryProvider.of<PostsRepository>(context);
    return StreamBuilder(
      stream:
          posts.getPosts().orderBy('timestamp', descending: true).snapshots(),
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
        return PostBuilder(items: items);
      },
    );
  }
}

class PostBuilder extends StatelessWidget {
  const PostBuilder({
    super.key,
    required this.items,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> items;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.all(4.0),
          child: Divider(
            indent: 12,
            endIndent: 12,
            thickness: 1,
            color: Colors.grey,
          ),
        );
      },
      itemBuilder: (context, index) {
        final postId = items[index].id;
        final data = items[index].data();
        DocumentReference userRef = data['user'];

        return FutureBuilder(
            future: userRef.get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const PostShimmer();
              }
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return PostView(postId: postId, userData: userData, data: data);
            });
      },
      itemCount: items.length,
    );
  }
}
