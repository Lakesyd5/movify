import 'package:dartz/dartz.dart';
import 'package:movify/core/error/server_failure.dart';
import 'package:movify/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getTrendingMovies();
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, List<Movie>>> getPopularMovies();
}
