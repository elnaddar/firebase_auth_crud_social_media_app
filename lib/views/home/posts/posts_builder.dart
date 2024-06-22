import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_crud_social_media_app/cubits/posts_cubit/posts_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/cubits/user_cubit/user_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/models/post.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/posts/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsBuilder extends StatelessWidget {
  const PostsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<PostsRepository>(context);
    return BlocProvider(
      create: (context) => PostsCubit(repo),
      child: BlocBuilder<PostsCubit, PostsState>(
        buildWhen: (previous, current) {
          final bothIsSuc = previous is PostsSuccess && current is PostsSuccess;
          final lengthIsDeff = bothIsSuc && previous.length != current.length;
          if (lengthIsDeff) {
            return true;
          }
          if (bothIsSuc) {
            return false;
          } else {
            return true;
          }
        },
        builder: (context, state) {
          if (state is PostsLoading || state is PostsInitial) {
            return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator.adaptive()));
          }
          if (state is PostsSuccess && state.length == 0) {
            return const SliverToBoxAdapter(
                child: Center(child: Text("No posts till now.")));
          }
          if (state is PostsSuccess) {
            return PostBuilder(items: state.posts);
          }
          return const SliverToBoxAdapter(
            child: Center(child: Text("Something went wrong try again.")),
          );
        },
      ),
    );
  }
}

class PostBuilder extends StatelessWidget {
  final List<QueryDocumentSnapshot<Post>> items;

  const PostBuilder({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(),
      child: SliverList.separated(
        itemCount: items.length,
        separatorBuilder: _separatorBuilder,
        itemBuilder: _itemBuilder,
      ),
    );
  }

  Widget? _separatorBuilder(context, index) {
    return const Padding(
      padding: EdgeInsets.all(4.0),
      child: Divider(
        indent: 12,
        endIndent: 12,
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }

  Widget? _itemBuilder(context, index) {
    final data = items[index].data();
    final userRef = data.user;
    final userId = userRef.id;
    return BlocBuilder<UserCubit, Map<String, Map<String, dynamic>>>(
      builder: (context, userCache) {
        if (userCache.containsKey(userId)) {
          return PostView(
              postId: data.id, userData: userCache[userId]!, data: data);
        } else {
          return FutureBuilder<DocumentSnapshot>(
            future: userRef.get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const PostShimmer();
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text("Error loading user data."));
              }
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              context.read<UserCubit>().cacheUserData(userId, userData);
              return PostView(postId: data.id, userData: userData, data: data);
            },
          );
        }
      },
    );
  }
}
