import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/domain/usecases/get_popular_movies.dart';
import 'package:movify/presentation/bloc/popular_movies/popular_movies.state.dart';
import 'package:movify/presentation/bloc/popular_movies/popular_movies_event.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetpopularMovies getpopularMovies;

  PopularMoviesBloc({required this.getpopularMovies}) : super(PopularMoviesInitial()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());
      final failureOrMovies = await getpopularMovies();

      failureOrMovies.fold(
        (failure) => emit(PopularMoviesError(failure.toString())),
        (movies) => emit(PopularMoviesLoaded(movies)),
      );
    });
  }
}
