import 'package:dartz/dartz.dart';

import 'package:restaurant_app/core/error/failure.dart';
import 'package:restaurant_app/core/usecases/usecase.dart';
import 'package:restaurant_app/restaurant/domain/repositories/restaurant_repository.dart';

import '../entities/restaurant.dart';

class GetRestaurantList extends UseCase<List<Restaurant>, NoParams> {
  final RestaurantRepository repository;
  GetRestaurantList({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<Restaurant>>> call(NoParams params)  {
    return repository.getRestaurantList();
  }
}
