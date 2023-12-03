import 'package:dartz/dartz.dart';
import 'package:movify/core/error/server_failure.dart';
import 'package:movify/domain/entities/movie.dart';
import 'package:movify/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);
  
  Future<Either<Failure, List<Movie>>> call(String query) async {
    return await repository.searchMovies(query);
  }
}