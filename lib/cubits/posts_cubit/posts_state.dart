part of 'posts_cubit.dart';

@immutable
sealed class PostsState {
  const PostsState();
}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PostsSuccess extends PostsState {
  final List<QueryDocumentSnapshot<Post>> posts;
  final int length;
  const PostsSuccess(this.posts) : length = posts.length;
}

final class PostsFailure extends PostsState {
  final String error;
  const PostsFailure(this.error);
}
