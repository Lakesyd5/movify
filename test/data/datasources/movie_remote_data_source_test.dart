import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movify/core/error/server_exception.dart';
import 'package:movify/data/datasources/movie_remote_data_source.dart';
import 'package:movify/data/datasources/remote/movie_remote_data_source_impl.dart';

import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MovieRemoteDataSource datasource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    datasource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  const tQuery = 'spiderman';

  const tUrl = 'https://api.themoviedb.org/3/trending/movie/day?api_key=0e601e6a31985dec986450472c347085';
  const pUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=0e601e6a31985dec986450472c347085';
  const sUrl = 'https://api.themoviedb.org/3/search/movie?query=$tQuery&api_key=0e601e6a31985dec986450472c347085';

  const String sampleApiResponse = '''
 {
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/path.jpg",
      "id": 1,
      "title": "Sample Movie",
      "original_language": "en",
      "original_title": "Sample Movie",
      "overview": "Overview here",
      "poster_path": "/path2.jpg",
      "media_type": "movie",
      "genre_ids": [1, 2, 3],
      "popularity": 100.0,
      "release_date": "2020-01-01",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 100
    }
  ],
  "total_pages": 1,
  "total_results": 1
 }
 ''';

  test('make a GET request to the api client to get trending movies', () async {
    // arrange
    when(mockHttpClient.get(Uri.parse(tUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    // act
    await datasource.getTrendingMovies();

    // assert
    verify(mockHttpClient.get(Uri.parse(tUrl)));
  });

  test('make a GET request to the api clinet to get popular movies', () async {
    when(mockHttpClient.get(Uri.parse(pUrl))).thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    await datasource.getPopularMovies();

    verify(mockHttpClient.get(Uri.parse(pUrl)));
  });

  test('make a Get request to the api for movies searched through the query', () async {
    when(mockHttpClient.get(Uri.parse(sUrl))).thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    await datasource.searchMovies(tQuery);

    verify(mockHttpClient.get(Uri.parse(sUrl)));
  });

  test('should throw ServerExcpetion when the errorCode is 404', () async {
    // arrange
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Our Api response', 404));

    // act
    final call = datasource.getTrendingMovies;

    // assert
    expect(() => call(), throwsA(isA<ServerException>()));
  });
}
