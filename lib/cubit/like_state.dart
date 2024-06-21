part of 'like_cubit.dart';

@immutable
sealed class LikeState {
  const LikeState();
}

class LikeInitial extends LikeState {}

class LikeLoading extends LikeState {}

class LikeSuccess extends LikeState {
  final bool isLiked;
  const LikeSuccess(this.isLiked);
}

class LikeFailure extends LikeState {
  final String error;

  const LikeFailure(this.error);
}
