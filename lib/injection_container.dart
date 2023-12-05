import 'package:get_it/get_it.dart';
import 'package:movify/data/datasources/movie_remote_data_source.dart';
import 'package:movify/data/datasources/remote/movie_remote_data_source_impl.dart';
import 'package:movify/data/repositories/movie_repository_impl.dart';
import 'package:movify/domain/repositories/movie_repository.dart';
import 'package:movify/domain/usecases/get_popular_movies.dart';
import 'package:movify/domain/usecases/get_trending_movies.dart';
import 'package:movify/domain/usecases/search_movies.dart';
import 'package:movify/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movify/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movify/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:http/http.dart' as http;

final GetIt getIt = GetIt.instance;

void init() {
  // Bloc
  getIt.registerFactory<PopularMoviesBloc>(() => PopularMoviesBloc(getpopularMovies: getIt()));
  getIt.registerFactory<TrendingMoviesBloc>(() => TrendingMoviesBloc(getTrendingMovies: getIt()));
  getIt.registerFactory<SearchMoviesBloc>(() => SearchMoviesBloc(searchMovies: getIt()));

  // Usecases
  getIt.registerLazySingleton(() => GetpopularMovies(getIt()));
  getIt.registerLazySingleton(() => GetTrendingMovies(getIt()));
  getIt.registerLazySingleton(() => SearchMovies(getIt()));

  // Repositories
  getIt.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl( remoteDataSource: getIt()));

  // Data sources
  getIt.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: getIt()));

  // Http service
  getIt.registerLazySingleton(() => http.Client());
}