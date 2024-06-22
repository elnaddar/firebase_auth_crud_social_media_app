import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_crud_social_media_app/cubits/user_cubit/user_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/models/post.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/posts/post_view/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsViewBuilder extends StatefulWidget {
  const PostsViewBuilder({
    super.key,
    required this.userId,
    required this.data,
    required this.userRef,
    required this.index,
  });
  final int index;
  final String userId;
  final Post data;
  final DocumentReference<Object?> userRef;

  @override
  State<PostsViewBuilder> createState() => _PostsViewBuilderState();
}

class _PostsViewBuilderState extends State<PostsViewBuilder>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print(widget.index);
    super.build(context); // Important: Call super.build
    return BlocBuilder<UserCubit, Map<String, Map<String, dynamic>>>(
      builder: (context, userCache) {
        if (userCache.containsKey(widget.userId)) {
          return PostView(
              postId: widget.data.id,
              userData: userCache[widget.userId]!,
              data: widget.data);
        } else {
          return FutureBuilder<DocumentSnapshot>(
            future: widget.userRef.get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const PostShimmer();
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text("Error loading user data."));
              }
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              context.read<UserCubit>().cacheUserData(widget.userId, userData);
              return PostView(
                  postId: widget.data.id,
                  userData: userData,
                  data: widget.data);
            },
          );
        }
      },
    );
  }
}
