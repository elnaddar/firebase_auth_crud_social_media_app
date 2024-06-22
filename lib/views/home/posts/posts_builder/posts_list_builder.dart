import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_crud_social_media_app/cubits/user_cubit/user_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/models/post.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/posts/post_view/post_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsListBuilder extends StatelessWidget {
  final List<QueryDocumentSnapshot<Post>> items;

  const PostsListBuilder({super.key, required this.items});

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
    return PostsViewBuilder(
      userId: userId,
      data: data,
      userRef: userRef,
      index: index,
    );
  }
}
