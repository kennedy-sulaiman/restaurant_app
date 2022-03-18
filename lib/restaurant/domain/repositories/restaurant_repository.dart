import 'package:dartz/dartz.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant.dart';

import '../../../core/error/failure.dart';
import '../entities/restaurant_detail.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurantList();
  Future<Either<Failure, RestaurantDetail>> getRestaurantDetail(String query);
  Future<Either<Failure, List<Restaurant>>> searchRestaurant(String query);
}
