import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/movie.dart';

class Api {
  static const _mostwatchedUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apikey}';
  static const _topratedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apikey}';
  static const _upcomingUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apikey}';
  static const _searchUrl =
      'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apikey}&query=';

  // Fetch detailed movie information by movieId
  Future<Movie> getMovieDetails(String movieId) async {
    final movieDetailsUrl =
        'https://api.themoviedb.org/3/movie/$movieId?api_key=${Constants.apikey}';
    final response = await http.get(Uri.parse(movieDetailsUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      return Movie.fromJson(decodedData);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  // Fetch most watched movies
  Future<List<Movie>> getMostWatched() async {
    final response = await http.get(Uri.parse(_mostwatchedUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to fetch most watched movies');
    }
  }

  // Fetch top rated movies
  Future<List<Movie>> getTopRated() async {
    final response = await http.get(Uri.parse(_topratedUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to fetch top rated movies');
    }
  }

  // Fetch upcoming movies
  Future<List<Movie>> getUpcoming() async {
    final response = await http.get(Uri.parse(_upcomingUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to fetch upcoming movies');
    }
  }

  // Search movies by query
  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    final searchUrl = _searchUrl + query;
    final response = await http.get(Uri.parse(searchUrl));

    if (response.statusCode == 200) {
      final searchJson = json.decode(response.body)['results'] as List;
      return searchJson
          .where((item) =>
      item['title'] != null &&
          item['poster_path'] != null &&
          item['vote_average'] != null)
          .map((item) => {
        'title': item['title'],
        'poster_path': item['poster_path'],
        'vote_average': item['vote_average'],
      })
          .take(20)
          .toList();
    } else {
      throw Exception('Failed to fetch search results');
    }
  }
}
