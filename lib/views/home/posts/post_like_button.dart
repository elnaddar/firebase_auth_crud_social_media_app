import 'package:firebase_auth_crud_social_media_app/cubits/like_cubit/like_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostLikeButton extends StatelessWidget {
  final String postId;

  const PostLikeButton({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final postsRepo = context.read<PostsRepository>();

    return BlocProvider(
      create: (context) =>
          LikeCubit(postsRepository: postsRepo, postId: postId),
      child: BlocListener<LikeCubit, LikeState>(
        listener: (context, state) {
          if (state is LikeFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<LikeCubit, LikeState>(
          builder: (context, state) {
            if (state is LikeInitial) {
              return const LoadingButton();
            }
            if (state is LikeLoading) {
              return const LoadingButton();
            }
            if (state is LikeSuccess) {
              return LikeButton(
                isLiked: state.isLiked,
                count: state.count,
              );
            }
            return const LikeButton(isLiked: false, count: 0);
          },
        ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: TextButton(
        style: TextButton.styleFrom(
          side: const BorderSide(color: Colors.black54),
        ),
        onPressed: null,
        child: const SizedBox.square(
          dimension: 15,
          child: CircularProgressIndicator(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final int count;
  const LikeButton({
    super.key,
    required this.isLiked,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    late final ButtonStyle style;
    late final IconData icon;
    final String label = count == 0 ? "Love" : count.toString();
    if (isLiked) {
      icon = Icons.favorite;
      style = TextButton.styleFrom(
        side: const BorderSide(color: Colors.pink),
        foregroundColor: Colors.pink,
      );
    } else {
      icon = Icons.favorite_border;
      style = TextButton.styleFrom(
        side: const BorderSide(color: Colors.black54),
      );
    }
    return SizedBox(
      width: 100,
      child: TextButton.icon(
        onPressed: () => context.read<LikeCubit>().toggleLike(),
        style: style,
        icon: Icon(icon, size: 18),
        label: Text(label),
      ),
    );
  }
}
