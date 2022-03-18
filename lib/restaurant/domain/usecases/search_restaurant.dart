import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:restaurant_app/core/error/failure.dart';
import 'package:restaurant_app/core/usecases/usecase.dart';
import 'package:restaurant_app/restaurant/domain/repositories/restaurant_repository.dart';

import '../entities/restaurant.dart';
import 'params.dart';

class SearchRestaurant extends UseCase<List<Restaurant>, Params> {
  final RestaurantRepository repository;
  SearchRestaurant({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<Restaurant>>> call(Params params) {
    return repository.searchRestaurant(params.name);
  }
}

