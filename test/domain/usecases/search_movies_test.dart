import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movify/domain/entities/movie.dart';
import 'package:movify/domain/usecases/search_movies.dart';

import 'get_trending_movies_test.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  const tQuery = 'Inception';

  final allMoviesList = [
    Movie(id: 1, title: 'Spider-Man', overview: 'testing spiderMan & his people in the testverse', posterPath: '/image1'),
    Movie(id: 2, title: 'Black Panther', overview: 'wakanda is about to be wiped out...who would save them', posterPath: '/image2'),
  ];

  test('should get searched movies through the query from the repository', () async {
    when(mockMovieRepository.searchMovies(any)).thenAnswer((realInvocation) async => allMoviesList);

    final result = await usecase(tQuery);

    expect(result, allMoviesList);
    verify(mockMovieRepository.searchMovies(any));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
