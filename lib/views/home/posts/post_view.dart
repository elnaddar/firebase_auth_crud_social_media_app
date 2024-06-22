import 'package:firebase_auth_crud_social_media_app/components/app_shimmer.dart';
import 'package:firebase_auth_crud_social_media_app/components/user_tile.dart';
import 'package:firebase_auth_crud_social_media_app/helpers/format_timestamp.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/posts/post_like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PostView extends StatelessWidget {
  const PostView({
    super.key,
    required this.postId,
    required this.userData,
    required this.data,
  });
  final String postId;
  final Map<String, dynamic> userData;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserTile(user: userData),
          const Divider(
            indent: 18,
            endIndent: 18,
            thickness: 1,
            color: Color.fromARGB(23, 158, 158, 158),
          ),
          Markdown(
            data: data['content'],
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PostLikeButton(
                  key: ValueKey(postId),
                  postId: postId,
                ),
                Text(formatTimestamp(data['timestamp'])),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PostShimmer extends StatelessWidget {
  const PostShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const AppShimmer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserTileShimmer(),
            Divider(
              indent: 18,
              endIndent: 18,
              thickness: 1,
              color: Color.fromARGB(23, 158, 158, 158),
            ),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 14,
                    width: double.infinity,
                    child: ColoredBox(color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    height: 14,
                    width: double.infinity,
                    child: ColoredBox(color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    height: 14,
                    width: double.infinity,
                    child: ColoredBox(color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    height: 14,
                    width: 40,
                    child: ColoredBox(color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LikedButton(onPressed: null),
                  SizedBox(
                    height: 16,
                    width: 100,
                    child: ColoredBox(color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
