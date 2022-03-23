import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/core/error/exception.dart';
import 'package:restaurant_app/restaurant/data/datasources/restaurant_remote_data_sources.dart';
import 'package:restaurant_app/restaurant/data/models/restaurant_detail_response.dart';
import 'package:restaurant_app/restaurant/data/models/restaurant_response.dart';

import '../../fixtures/common.dart';
import '../../fixtures/fixtures_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late RestaurantRemoteDataSourceImpl remoteData;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    mockHttpClient = MockHttpClient();
    remoteData = RestaurantRemoteDataSourceImpl(client: mockHttpClient);
    registerFallbackValue(FakeUri());
  });

  const BASE_URL = "https://restaurant-api.dicoding.dev/";

  void setUpMockHttpClientSuccess200(String url, String json) {
    when(() => mockHttpClient.get(Uri.parse(url))).thenAnswer(
        (invocation) async => http.Response(readFixtures(json), 200));
  }

  void setUpMockHttpClientFailure404(String url) {
    when(() => mockHttpClient.get(Uri.parse(url))).thenAnswer(
        (invocation) async => http.Response("404 Something went wrong", 404));
  }

  group('Get Restaurant Detail', () {
    final String tId = "rqdv5juczeskfw1e867";
    final String url = "$BASE_URL/detail/$tId";
    final String readJson = 'restaurant_detail.json';
    test('should perform a GET request on a URL ', () {
      setUpMockHttpClientSuccess200(url, readJson);
      remoteData.getRestaurantDetail(tId);

      verify(() => mockHttpClient.get(Uri.parse("$BASE_URL/detail/$tId")));
    });

    test('should return Restaurant Detail Model when status code response 200',
        () async {
      setUpMockHttpClientSuccess200(url, readJson);
      final result = await remoteData.getRestaurantDetail(tId);
      expect(result, equals(tRestaurantDetailModel));
    });

    test('should throw a ServerException when the response 404 or error', () {
      setUpMockHttpClientFailure404(url);
      final call = remoteData.getRestaurantDetail;
      expect(() => call(tId), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('Get Restaurant List', () {
    final String url = "$BASE_URL/list";
    final String readJson = 'restaurant_list.json';
    test('should preform GET request on a URL ', () async {
      setUpMockHttpClientSuccess200(url, readJson);
      remoteData.getRestaurantList();
      verify(() => mockHttpClient.get(Uri.parse(url)));
    });

    test('should return Restaurant Model when status connection success 200',
        () async {
      final tRestaurantModelList =
          RestaurantResponse.fromJson(readFixtures(readJson)).restaurantList;
      setUpMockHttpClientSuccess200(url, readJson);
      final result = await remoteData.getRestaurantList();
      expect(result, equals(tRestaurantModelList));
    });

    test('should throw Exception when status connection 404', () {
      setUpMockHttpClientFailure404(url);
      final call = remoteData.getRestaurantList;
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
  group('Search Restaurant', () {
      final String query = "Makan mudah";
      final String url = "$BASE_URL/search?q=$query";
      final String readJson = 'restaurant_list.json';
      test('should preform a GET request from API', () {
        setUpMockHttpClientSuccess200(url, readJson);
        remoteData.searchRestaurant(query);

        verify(() => mockHttpClient.get(Uri.parse(url)));
        verifyNoMoreInteractions(mockHttpClient);
      });

      test('should return spesific restaurant from query when connection status is 200', () async {
        setUpMockHttpClientSuccess200(url, readJson);
        final tRestaurantModelList =
            RestaurantResponse.fromJson(readFixtures(readJson)).restaurantList;
        final result = await remoteData.searchRestaurant(query);
        expect(result, tRestaurantModelList);
      });
    });
}
