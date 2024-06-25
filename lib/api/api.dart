import 'dart:convert';

import 'package:firebase_login/constants.dart';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class Api {
  static const _mostwatchedUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apikey}';

  static const _topratedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apikey}';

  static const _upcommingUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apikey}';

  static const _searchUrl =
      'https://api.themoviedb.org/3/movie/343611?api_key=${Constants.apikey}';


  //For Most watched
  Future<List<Movie>>getMostWatched() async{
    final response = await http.get(Uri.parse(_mostwatchedUrl));

    if(response.statusCode== 200){
      final decodedData = json.decode(response.body)['results'] as List; //we are accessing the entire body of api
      print(decodedData);
      return decodedData.map((movie)=> Movie.fromJason(movie)).toList();
    }
    else{
      throw Exception('Something went wrong!!!');
    }

  }

//For TopRated
  Future<List<Movie>>getTopRated() async{
    final response = await http.get(Uri.parse(_topratedUrl));

    if(response.statusCode== 200){
      final decodedData = json.decode(response.body)['results'] as List; //we are accessing the entire body of api
      print(decodedData);
      return decodedData.map((movie)=> Movie.fromJason(movie)).toList();
    }
    else{
      throw Exception('Something went wrong!!!');
    }

}

//For upcomming
  Future<List<Movie>>getUpcomming() async{
    final response = await http.get(Uri.parse(_upcommingUrl));

    if(response.statusCode== 200){
      final decodedData = json.decode(response.body)['results'] as List; //we are accessing the entire body of api
      print(decodedData);
      return decodedData.map((movie)=> Movie.fromJason(movie)).toList();
    }
    else{
      throw Exception('Something went wrong!!!');
    }

  }
}
