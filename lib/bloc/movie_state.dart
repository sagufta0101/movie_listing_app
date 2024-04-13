part of 'movie_bloc.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}

final class MovieSuccess extends MovieState {
  final List<MovieModel> movieModel;
  MovieSuccess({required this.movieModel});
}

final class MovieFailure extends MovieState {
  final String error;

  MovieFailure(this.error);
}

final class MovieLoading extends MovieState {}
