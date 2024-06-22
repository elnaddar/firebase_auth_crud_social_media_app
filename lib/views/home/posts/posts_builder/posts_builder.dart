import 'package:firebase_auth_crud_social_media_app/cubits/posts_cubit/posts_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/cubits/user_cubit/user_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:firebase_auth_crud_social_media_app/views/home/posts/posts_builder/posts_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsBuilder extends StatelessWidget {
  const PostsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<PostsRepository>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostsCubit(repo),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
      ],
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
            return PostsListBuilder(items: state.posts);
          }
          return const SliverToBoxAdapter(
            child: Center(child: Text("Something went wrong try again.")),
          );
        },
      ),
    );
  }
}
