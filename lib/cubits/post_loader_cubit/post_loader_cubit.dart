import 'dart:async';

import 'package:firebase_auth_crud_social_media_app/cubits/cubit_provider_mixin.dart';
import 'package:firebase_auth_crud_social_media_app/cubits/like_cubit/like_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/cubits/user_cubit/user_cubit.dart';
import 'package:firebase_auth_crud_social_media_app/models/post.dart';
import 'package:firebase_auth_crud_social_media_app/repository/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_loader_state.dart';

class PostLoaderCubit extends Cubit<PostLoaderState>
    with CubitProviderMixin<PostLoaderCubit> {
  PostLoaderCubit(this.repo, this.userCubit, this.likeCubit, this.post)
      : super(PostLoaderInitial()) {
    _init();
  }

  final PostsRepository repo;
  final Post post;
  final LikeCubit likeCubit;
  final UserCubit userCubit;

  bool likeSucc = false;
  bool userSucc = false;

  late final StreamSubscription _likeSubscription;
  late final StreamSubscription _userSubscription;
  bool _isSubscriptionActive = true;

  void _init() {
    _handleUserCache(userCubit.state);
    _likeSubscription = likeCubit.stream.listen(_handleLikeState);
    _userSubscription = userCubit.stream.listen(_handleUserCache);
  }

  void _handleLikeState(LikeState likeState) {
    if (likeState is LikeFailure) {
      emit(PostLoaderFailure(likeState.error));
    } else if (likeState is LikeSuccess) {
      likeSucc = true;
      _checkAndEmitPostLoaderState();
    } else {
      emit(PostLoaderLoading());
    }
  }

  void _handleUserCache(Map<String, dynamic> userCache) {
    if (userCache.containsKey(post.user.id)) {
      userSucc = true;
      _checkAndEmitPostLoaderState();
    } else {
      _fetchAndCacheUserData();
    }
  }

  void _fetchAndCacheUserData() {
    post.user.get().then((value) {
      final userData = value.data() as Map<String, dynamic>;
      userCubit.cacheUserData(post.user.id, userData);
      userSucc = true;
      _checkAndEmitPostLoaderState();
    }).catchError((error) {
      emit(PostLoaderFailure(error.toString()));
    });
    emit(PostLoaderLoading());
  }

  void _checkAndEmitPostLoaderState() {
    if (likeSucc && userSucc) {
      emit(PostLoaderSuccess());
      _closSubsctiptions();
    } else {
      emit(PostLoaderLoading());
    }
  }

  _closSubsctiptions() {
    if (_isSubscriptionActive) {
      _likeSubscription.cancel();
      _userSubscription.cancel();
      _isSubscriptionActive = false;
    }
  }

  @override
  Future<void> close() {
    _closSubsctiptions();
    likeCubit.close();
    return super.close();
  }
}
