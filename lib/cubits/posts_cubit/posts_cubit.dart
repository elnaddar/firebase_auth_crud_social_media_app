import 'package:firebase_auth_crud_social_media_app/models/post.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository repo;
  PostsCubit(this.repo) : super(PostsInitial());

  getPosts() {
    return repo
        .getPosts()
        .orderBy('timestamp', descending: true)
        .withConverter<Post>(
      fromFirestore: (snapshot, options) {
        return Post.fromMap(snapshot.data() ?? {});
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    ).snapshots();
  }
}
