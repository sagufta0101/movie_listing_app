import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/movie_repository.dart';
import '../models/movie_models.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<MovieFetched>(_getMovies);
  }

  void _getMovies(MovieFetched event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await movieRepository.getMovieList();
      emit(MovieSuccess(movieModel: movies));
    } catch (e) {
      emit(MovieFailure(e.toString()));
    }
  }
}
