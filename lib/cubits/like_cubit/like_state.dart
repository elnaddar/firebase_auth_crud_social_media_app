part of 'like_cubit.dart';

@immutable
sealed class LikeState {
  const LikeState();
}

class LikeInitial extends LikeState {}

class LikeLoading extends LikeState {}

class LikeSuccess extends LikeState {
  final bool isLiked;
  final int count;
  const LikeSuccess(this.isLiked, this.count);
}

class LikeFailure extends LikeState {
  final String error;

  const LikeFailure(this.error);
}
