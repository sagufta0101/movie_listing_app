import 'dart:convert';
import 'dart:developer';

import '../../models/movie_models.dart';
import '../data_provider/movie_data_provider.dart';

class MovieRepository {
  final MovieDataProvider movieDataProvider;

  MovieRepository(this.movieDataProvider);

  Future<List<MovieModel>> getMovieList() async {
    try {
      final movieData = await movieDataProvider.getMovies();

      final List<dynamic> data = jsonDecode(movieData);

      return List<MovieModel>.from(data.map(
          (json) => MovieModel.fromJson(json["show"] as Map<String, dynamic>)));
    } catch (e) {
      throw e.toString();
    }
  }
}
