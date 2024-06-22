import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_crud_social_media_app/models/post.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository repo;
  PostsCubit(this.repo) : super(PostsInitial()) {
    _init();
  }

  Future<void> _init() async {
    try {
      getPosts().listen((event) {
        if (state is! PostsSuccess ||
            event.size != (state as PostsSuccess).length) {
          emit(PostsSuccess(event.docs));
        }
      });
    } catch (e) {
      emit(PostsFailure(e.toString()));
    }
  }

  Stream<QuerySnapshot<Post>> getPosts() {
    return repo
        .getPosts()
        .orderBy('timestamp', descending: true)
        .withConverter<Post>(
      fromFirestore: (snapshot, options) {
        final map = {
          'id': snapshot.id,
          ...snapshot.data()!,
        };
        return Post.fromMap(map);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    ).snapshots();
  }
}
