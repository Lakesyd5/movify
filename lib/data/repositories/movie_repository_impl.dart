import 'package:dartz/dartz.dart';
import 'package:movify/core/error/server_exception.dart';
import 'package:movify/core/error/server_failure.dart';
import 'package:movify/data/datasources/movie_remote_data_source.dart';
import 'package:movify/data/models/movie_model.dart';
import 'package:movify/domain/entities/movie.dart';
import 'package:movify/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, List<Movie>>> getPopularMovies() async {
    try {
      final List<MovieModel> movieModels = await remoteDataSource.getPopularMovies();
      final List<Movie> movies = movieModels.map((model) => model.toEntity()).toList();
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, List<Movie>>> getTrendingMovies() async {
    try {
      final List<MovieModel> movieModels = await remoteDataSource.getTrendingMovies();
      final List<Movie> movies = movieModels.map((model) => model.toEntity()).toList();
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, List<Movie>>> searchMovies(String query) async {
    try {
      final List<MovieModel> movieModels = await remoteDataSource.searchMovies(query);
      final List<Movie> movies = movieModels.map((model) => model.toEntity()).toList();
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
