import 'dart:convert';

import 'package:movify/core/error/server_exception.dart';
import 'package:movify/data/datasources/movie_remote_data_source.dart';
import 'package:movify/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl(this.client);

  static const BASE_URL = 'https://api.themoviedb.org/3';
  static const API_KEY = '0e601e6a31985dec986450472c347085';

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/popular?api_key=$API_KEY'));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await client
        .get(Uri.parse('$BASE_URL/trending/movie/day?api_key=$API_KEY'));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/search/movie?query=$query&api_key=$API_KEY'));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }
}
