import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/error/failure.dart';
import 'package:restaurant_app/core/usecases/usecase.dart';
import 'package:restaurant_app/restaurant/domain/repositories/restaurant_repository.dart';

import '../entities/restaurant_detail.dart';
import 'params.dart';

class GetRestaurantDetail extends UseCase<RestaurantDetail, Params> {
  final RestaurantRepository repository;
  GetRestaurantDetail({
    required this.repository,
  });

  @override
  Future<Either<Failure, RestaurantDetail>> call(Params params) {
    return repository.getRestaurantDetail(params.name);
  }
}

