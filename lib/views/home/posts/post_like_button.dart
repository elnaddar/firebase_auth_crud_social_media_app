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
            if (state is LikeLoading) {
              return const LoadingButton();
            }
            if (state is LikeSuccess && state.isLiked) {
              return LikedButton(
                  onPressed: () => context.read<LikeCubit>().toggleLike());
            }
            return UnlikedButton(
                onPressed: () => context.read<LikeCubit>().toggleLike());
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

class LikedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LikedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: TextButton.icon(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          side: const BorderSide(color: Colors.pink),
          foregroundColor: Colors.pink,
        ),
        icon: const Icon(
          Icons.favorite,
          size: 18,
        ),
        label: const Text("Love"),
      ),
    );
  }
}

class UnlikedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UnlikedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: TextButton.icon(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          side: const BorderSide(color: Colors.black54),
        ),
        icon: const Icon(
          Icons.favorite_border,
          size: 18,
        ),
        label: const Text("Love"),
      ),
    );
  }
}
