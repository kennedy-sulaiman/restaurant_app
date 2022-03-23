import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/error/exception.dart';

import 'package:restaurant_app/core/error/failure.dart';
import 'package:restaurant_app/core/network/network_info.dart';
import 'package:restaurant_app/restaurant/data/datasources/restaurant_remote_data_sources.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant_detail.dart';
import 'package:restaurant_app/restaurant/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final NetworkInfo networkInfo;
  final RestaurantRemoteDataSource remoteDataSource;

  RestaurantRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, RestaurantDetail>> getRestaurantDetail(
      String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getRestaurantDetail(query);
        return Right(remote);
      } on ServerException {
        return Left(ServerFailures());
      }
    } else {
      throw Exception();
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurantList() async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getRestaurantList();
        return Right(remote);
      } on ServerException {
        return Left(ServerFailures());
      }
    } else {
      throw Exception();
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> searchRestaurant(
      String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.searchRestaurant(query);
        return Right(remote);
      } on ServerException {
        return Left(ServerFailures());
      }
    } else {
      throw Exception();
    }
  }
}
