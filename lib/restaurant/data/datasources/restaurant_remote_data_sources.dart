import 'package:http/http.dart' as http;
import 'package:restaurant_app/core/error/exception.dart';

import '../models/restaurant_detail_model.dart';
import '../models/restaurant_detail_response.dart';
import '../models/restaurant_model.dart';
import '../models/restaurant_response.dart';


abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurantList();
  Future<RestaurantDetailModel> getRestaurantDetail(String query);
  Future<List<RestaurantModel>> searchRestaurant(String query);
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  static const BASE_URL = "https://restaurant-api.dicoding.dev";
  final http.Client client;

  RestaurantRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<RestaurantDetailModel> getRestaurantDetail(String query) async {
    final response = await client.get(Uri.parse("$BASE_URL/detail/$query"));
    if (response.statusCode == 200) {
      return RestaurantDetailModelResponse.fromJson(response.body).restaurant;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RestaurantModel>> getRestaurantList() =>
      _getRestaurantFromUrl("$BASE_URL/list");

  @override
  Future<List<RestaurantModel>> searchRestaurant(String query) =>
      _getRestaurantFromUrl("$BASE_URL/search?q=$query");

  Future<List<RestaurantModel>> _getRestaurantFromUrl(String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(response.body).restaurantList;
    } else {
      throw ServerException();
    }
  }
}
