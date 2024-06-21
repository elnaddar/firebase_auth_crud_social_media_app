import 'package:firebase_auth_crud_social_media_app/cubit/like_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostLikeButton extends StatefulWidget {
  const PostLikeButton({
    super.key,
  });

  @override
  State<PostLikeButton> createState() => _PostLikeButtonState();
}

class _PostLikeButtonState extends State<PostLikeButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeCubit, LikeState>(
      builder: (context, state) {
        if (state is LikeLoading) {
          return TextButton(
            style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.black54)),
            onPressed: null,
            child: const CircularProgressIndicator(),
          );
        }
        if (state is LikeSuccess && state.isLiked) {
          return TextButton.icon(
            onPressed: () => context.read<LikeCubit>().toggleLike(),
            style: TextButton.styleFrom(
              side: const BorderSide(color: Colors.pink),
              foregroundColor: Colors.pink,
            ),
            icon: const Icon(
              Icons.favorite,
              size: 18,
            ),
            label: const Text("Love"),
          );
        }
        return TextButton.icon(
          onPressed: () => context.read<LikeCubit>().toggleLike(),
          style: TextButton.styleFrom(
            side: const BorderSide(color: Colors.black54),
          ),
          icon: const Icon(
            Icons.favorite_border,
            size: 18,
          ),
          label: const Text("Love"),
        );
      },
    );
  }
}
