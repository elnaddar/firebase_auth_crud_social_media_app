import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  final PostsRepository postsRepository;
  final String postId;

  LikeCubit({required this.postsRepository, required this.postId})
      : super(LikeInitial()) {
    _initializeLikeStatus();
  }

  Future<void> _initializeLikeStatus() async {
    try {
      final isLiked = await postsRepository.isPostLikedByUser(postId);
      emit(LikeSuccess(isLiked));
    } catch (e) {
      emit(LikeFailure(e.toString()));
    }
  }

  Future<void> toggleLike() async {
    emit(LikeLoading());
    try {
      await postsRepository.toggleLike(postId);
      _initializeLikeStatus(); // Refresh the like status after toggling
    } catch (e) {
      emit(LikeFailure(e.toString()));
    }
  }
}
