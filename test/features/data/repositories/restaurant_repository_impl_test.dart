import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/core/error/exception.dart';
import 'package:restaurant_app/core/error/failure.dart';
import 'package:restaurant_app/core/network/network_info.dart';
import 'package:restaurant_app/restaurant/data/datasources/restaurant_remote_data_sources.dart';
import 'package:restaurant_app/restaurant/data/models/restaurant_response.dart';
import 'package:restaurant_app/restaurant/data/repositories/restaurant_repository_impl.dart';

import '../../fixtures/common.dart';
import '../../fixtures/fixtures_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockRemoteDataSource extends Mock implements RestaurantRemoteDataSource {}

void main() {
  late RestaurantRepositoryImpl repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = RestaurantRepositoryImpl(
        networkInfo: mockNetworkInfo, remoteDataSource: mockRemoteDataSource);
  });

  group('Get Restaurant Detail', () {
    String query = "id";

    test('should check if device is online', () {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((invocation) async => true);
      repository.getRestaurantDetail(query);
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUpAll(() {
        when(() => mockNetworkInfo.isConnected)
            .thenAnswer((invocation) async => true);
      });

      test('should return remote if the call is successful', () async {
        when(() => mockRemoteDataSource.getRestaurantDetail(any()))
            .thenAnswer((invocation) async => tRestaurantDetailModel);
        final result = await repository.getRestaurantDetail(query);
        expect(result, const Right(tRestaurantDetailModel));
      });

      test('should return Server Exception when the call is unsuccessful',
          () async {
        when(() => mockRemoteDataSource.getRestaurantDetail(any()))
            .thenThrow(ServerException());
        final result = await repository.getRestaurantDetail(query);
        expect(result, equals(Left(ServerFailures())));
      });
    });
  });

  group('Get Restaurant List', () {
    final readJson = "restaurant_list.json";
    final tRestaurantModelList =
        RestaurantResponse.fromJson(readFixtures(readJson)).restaurantList;

    group('device is online', () {
      setUpAll(() {
        when(() => mockNetworkInfo.isConnected)
            .thenAnswer((invocation) async => true);
      });
      test('should check if device is online', () async {
        when(() => mockNetworkInfo.isConnected)
            .thenAnswer((invocation) async => true);
        repository.getRestaurantList();
        verify(() => mockNetworkInfo.isConnected);
      });

      test('should return remote if the call is successful', () async {
        when(() => mockRemoteDataSource.getRestaurantList())
            .thenAnswer((invocation) async => tRestaurantModelList);
        final remote = await repository.getRestaurantList();
        expect(remote, Right(tRestaurantModelList));
      });

      test('should throw error if the call is unsuccessful', () async {
        when(() => mockRemoteDataSource.getRestaurantList())
            .thenThrow(ServerException());
        final result = await repository.getRestaurantList();

        expect(result, equals(Left(ServerFailures())));
      });
    });

    group('search restaurant by query', () {
      final String query = "Makan mudah";
      final tRestaurantModelList =
          RestaurantResponse.fromJson(readFixtures(readJson)).restaurantList;

      group('device is online', () {
        setUpAll(() {
          when(() => mockNetworkInfo.isConnected)
              .thenAnswer((invocation) async => true);
        });

        test('should check if the device is online', () async {
          repository.searchRestaurant(query);
          verify(() => mockNetworkInfo.isConnected);
        });

        test('should return remote if the call is success', () async {
          when(() => mockRemoteDataSource.searchRestaurant(any()))
              .thenAnswer((invocation) async => tRestaurantModelList);
          final result = await repository.searchRestaurant(query);
          expect(result, Right(tRestaurantModelList));
        });

        test('should throws exception if the call is unsuccessful', () async {
          when(() => mockRemoteDataSource.searchRestaurant(any()))
              .thenThrow(ServerException());
          final result = await repository.searchRestaurant(query);
          expect(result , equals(Left(ServerFailures())));
        });
      });
    });
  });
}
