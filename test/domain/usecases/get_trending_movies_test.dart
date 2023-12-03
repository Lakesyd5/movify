import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movify/domain/entities/movie.dart';
import 'package:movify/domain/repositories/movie_repository.dart';
import 'package:movify/domain/usecases/get_trending_movies.dart';
// import 'package:mockito/annotations.dart';

import 'get_trending_movies_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])

void main() {
  late GetTrendingMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTrendingMovies(mockMovieRepository);
  });

  final tMoviesList = [
    Movie(id: 1, title: 'Spider-Man', overview: 'testing spiderMan & his people in the testverse', posterPath: '/image1'),
    Movie(id: 2, title: 'Black Panther', overview: 'wakanda is about to be wiped out...who would save them', posterPath: '/image2'),
  ];

  test('should get trending movies form the repository', () async{
    // arrange
    when(mockMovieRepository.getTrendingMovies()).thenAnswer((_) async => tMoviesList);

    // act
    final result = await usecase();

    // assert
    expect(result, tMoviesList);
    verify(mockMovieRepository.getTrendingMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
