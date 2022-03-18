// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/restaurant/data/models/restaurant_detail_model.dart';
import 'package:restaurant_app/restaurant/data/models/restaurant_detail_response.dart';
import 'package:restaurant_app/restaurant/data/models/restaurant_model.dart';
import 'package:restaurant_app/restaurant/data/models/restaurant_response.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant_detail.dart';

import '../../fixtures/common.dart';
import '../../fixtures/fixtures_reader.dart';

void main() {
  group('Restaurant', () {
    test('should be a subclass of Restaurant entity', () async {
      expect(tRestaurantModel, isA<Restaurant>());
    });

    test('from JSON - should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          jsonDecode(readFixtures('restaurant_list.json'));
      final tRestaurantResponseModel = RestaurantResponse(
          restaurantList: <RestaurantModel>[tRestaurantModel]);
      final result = RestaurantResponse.fromMap(jsonMap);
      expect(result, tRestaurantResponseModel);
    });

    test('to JSON - should return a valid json map containing proper data',
        () async {
      final result = tRestaurantModel.toMap();

      final expectedMap = {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2
      };

      expect(result, expectedMap);
    });
  });

  group('Restaurant Detail', () {
    test('should be a subclass of RestaurantDetail entity', () async {
      expect(tRestaurantDetailModel, isA<RestaurantDetail>());
    });

    test('from JSON - should return a valid model from JSON map', () async {
      final Map<String, dynamic> jsonMap =
          jsonDecode(readFixtures("restaurant_detail.json"));
      final restaurant = RestaurantDetailModelResponse.fromMap(jsonMap);
      final result = restaurant.restaurant;
      expect(result, tRestaurantDetailModel);
    });

    test('to JSON - should return a valid json containing data', () async {
      final result = tRestaurantDetailModel.toMap();

      final expectedMap = {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [categories1, categories2],
        "menus": menus,
        "rating": 4.2,
        "customerReviews": customerReviews
      };
    });
  });
}
