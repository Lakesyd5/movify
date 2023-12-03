import 'package:dartz/dartz.dart';
import 'package:movify/core/error/server_failure.dart';
import 'package:movify/domain/entities/movie.dart';
import 'package:movify/domain/repositories/movie_repository.dart';

class GetTrendingMovies {
  final MovieRepository repository;

  GetTrendingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call() async {
    return await repository.getTrendingMovies();
  }
}