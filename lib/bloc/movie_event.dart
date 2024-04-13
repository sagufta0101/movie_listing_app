part of 'movie_bloc.dart';

@immutable
sealed class MovieEvent {}

final class MovieFetched extends MovieEvent {}
