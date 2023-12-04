import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movify/core/error/server_exception.dart';
import 'package:movify/core/error/server_failure.dart';
import 'package:movify/data/datasources/movie_remote_data_source.dart';
import 'package:movify/data/models/movie_model.dart';
import 'package:movify/data/repositories/movie_repository_impl.dart';
import 'package:movify/domain/entities/movie.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRemoteDataSource>()])
void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    repository = MovieRepositoryImpl(remoteDataSource: mockMovieRemoteDataSource);
  });

  const String tQuery = 'Black Panther';

  // const tMoviesList = [
  //   Movie(id: 1, title: 'Spider-Man', overview: 'testing spiderMan & his people in the testverse', posterPath: '/image1'),
  //   Movie(id: 2, title: 'Black Panther', overview: 'wakanda is about to be wiped out...who would save them', posterPath: '/image2'),
  // ];

  final tMovieModelList = [
    MovieModel(id: 1, title: 'Spider-Man', overview: 'testing spiderMan & his people in the testverse', posterPath: '/image1'),
    MovieModel(id: 2, title: 'Black Panther', overview: 'wakanda is about to be wiped out...who would save them', posterPath: '/image2'),
  ];

  test('should get trending movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenAnswer((_) async => tMovieModelList);

    final result = await repository.getTrendingMovies();

    verify(mockMovieRemoteDataSource.getTrendingMovies());
    expect(result, isA<Right<ServerFailure, List<Movie>>>());
  });

  test('should get popular movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenAnswer((_) async => tMovieModelList);

    final result = await repository.getPopularMovies();

    verify(mockMovieRemoteDataSource.getPopularMovies());
    expect(result, isA<Right<ServerFailure, List<Movie>>>());   
  });

  test('should search movies fromt he remote data source', () async {
    when(mockMovieRemoteDataSource.searchMovies(tQuery)).thenAnswer((_) async => tMovieModelList);

    final result = await repository.searchMovies(tQuery);

    verify(mockMovieRemoteDataSource.searchMovies(tQuery));
    expect(result, isA<Right<ServerFailure, List<Movie>>>());
  });

  test('should return ServerFailure when the call to remote data source is unsuccessful to get Trending movies', () async {
    when(mockMovieRemoteDataSource.getTrendingMovies()).thenThrow(ServerException());

    final result = await repository.getTrendingMovies();

    expect(result, isA<Left<ServerFailure, List<Movie>>>());
  });

  test('should return ServerFailure when the call to remote data source is unsuccessful to get Popular movies', () async {
    when(mockMovieRemoteDataSource.getPopularMovies()).thenThrow(ServerException());

    final result = await repository.getPopularMovies();

    expect(result, isA<Left<ServerFailure, List<Movie>>>());
  });

  test('should return ServerFailure when the call to remote data source is unsuccessful to get Popular movies', () async {
    when(mockMovieRemoteDataSource.searchMovies(tQuery)).thenThrow(ServerException());

    final result = await repository.searchMovies(tQuery);

    expect(result, isA<Left<ServerFailure, List<Movie>>>());
  });
}
