
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movify/domain/entities/movie.dart';
import 'package:movify/domain/usecases/get_popular_movies.dart';

import 'get_trending_movies_test.mocks.dart';

void main() {
  late GetpopularMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetpopularMovies(mockMovieRepository);
  });

  const pMoviesList = [
    Movie(id: 1, title: 'Spider-Man', overview: 'testing spiderMan & his people in the testverse', posterPath: '/image1'),
    Movie(id: 2, title: 'Black Panther', overview: 'wakanda is about to be wiped out...who would save them', posterPath: '/image2'),
  ];

  test('should get popular movies form the repository', () async {
    when(mockMovieRepository.getPopularMovies()).thenAnswer((_) async => );

    final result = await usecase();

    expect(result, pMoviesList);
    verify(mockMovieRepository.getPopularMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}