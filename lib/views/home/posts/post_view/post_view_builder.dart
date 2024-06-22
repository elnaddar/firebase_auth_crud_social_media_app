import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_crud_social_media_app/cubits/like_cubit/like_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/cubits/post_loader_cubit/post_loader_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/cubits/user_cubit/user_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/models/post.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
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
  late final PostLoaderCubit _postLoaderCubit;
  late final LikeCubit _likeCubit;

  @override
  void initState() {
    super.initState();
    final repo = RepositoryProvider.of<PostsRepository>(context);
    final userCubit = BlocProvider.of<UserCubit>(context);
    _likeCubit = LikeCubit(postsRepository: repo, postId: widget.data.id);
    _postLoaderCubit = PostLoaderCubit(
      repo,
      userCubit,
      _likeCubit,
      widget.data,
    );
  }

  @override
  void dispose() {
    _postLoaderCubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _postLoaderCubit,
        ),
        BlocProvider.value(
          value: _likeCubit,
        ),
      ],
      child: BlocBuilder<PostLoaderCubit, PostLoaderState>(
        builder: (context, state) {
          if (state is PostLoaderSuccess) {
            final userState = _postLoaderCubit.userCubit.state;
            final userData = userState[widget.userId]!;
            return PostView(
              postId: widget.data.id,
              userData: userData,
              data: widget.data,
            );
          } else if (state is PostLoaderFailure) {
            return const Center(child: Text("Error loading user data."));
          } else {
            return const PostShimmer();
          }
        },
      ),
    );
  }
}
