import 'package:flutter/foundation.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'like_state.dart';

class LikeCubit extends HydratedCubit<LikeState> {
  final PostsRepository postsRepository;
  final String postId;

  LikeCubit({required this.postsRepository, required this.postId})
      : super(LikeInitial()) {
    _initializeLikeStatus();
  }

  Future<void> _initializeLikeStatus() async {
    try {
      final isLiked = await postsRepository.isPostLikedByUser(postId);
      if (!isClosed) emit(LikeSuccess(isLiked));
    } catch (e) {
      if (!isClosed) emit(LikeFailure(e.toString()));
    }
  }

  Future<void> toggleLike() async {
    emit(LikeLoading());
    try {
      await postsRepository.toggleLike(postId);
      if (!isClosed) _initializeLikeStatus();
    } catch (e) {
      if (!isClosed) emit(LikeFailure(e.toString()));
    }
  }

  @override
  LikeState? fromJson(Map<String, dynamic> json) {
    try {
      final bool isLiked = json['isLiked'] as bool;
      return LikeSuccess(isLiked);
    } catch (e) {
      return LikeInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(LikeState state) {
    if (state is LikeSuccess) {
      return {'isLiked': state.isLiked};
    }
    return null;
  }
}
