part of 'post_loader_cubit.dart';

@immutable
sealed class PostLoaderState {
  const PostLoaderState();
}

final class PostLoaderInitial extends PostLoaderState {}

final class PostLoaderLoading extends PostLoaderState {}

final class PostLoaderSuccess extends PostLoaderState {}

final class PostLoaderFailure extends PostLoaderState {
  final String error;
  const PostLoaderFailure(this.error);
}
