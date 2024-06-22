import 'package:flutter/foundation.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'like_state.dart';

class LikeCubit extends HydratedCubit<LikeState> {
  final PostsRepository postsRepository;
  final String postId;
  late List likes;

  LikeCubit({required this.postsRepository, required this.postId})
      : super(LikeInitial()) {
    _initializeLikeStatus();
  }

  Future<void> _initializeLikeStatus() async {
    try {
      likes = await postsRepository.getLikes(postId);
      final isLiked = postsRepository.isPostLikedByUser(postId, likes: likes);
      if (!isClosed) emit(LikeSuccess(isLiked, likes.length));
    } catch (e) {
      if (!isClosed) emit(LikeFailure(e.toString()));
    }
  }

  Future<void> toggleLike() async {
    emit(LikeLoading());
    try {
      await postsRepository.toggleLike(postId, currentList: likes);
      if (!isClosed) _initializeLikeStatus();
    } catch (e) {
      if (!isClosed) emit(LikeFailure(e.toString()));
    }
  }

  @override
  LikeState? fromJson(Map<String, dynamic> json) {
    try {
      final bool isLiked = json['isLiked'] as bool;
      final int likesCount = json['likesCount'] as int;
      return LikeSuccess(isLiked, likesCount);
    } catch (e) {
      return LikeInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(LikeState state) {
    if (state is LikeSuccess) {
      return {'isLiked': state.isLiked, 'likesCount': state.count};
    }
    return null;
  }
}
