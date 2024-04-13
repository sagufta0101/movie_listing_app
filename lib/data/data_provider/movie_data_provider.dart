import 'package:http/http.dart' as http;

class MovieDataProvider {
  Future<String> getMovies() async {
    try {
      final res = await http
          .get(Uri.parse('https://api.tvmaze.com/search/shows?q=spiderman'));

      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
