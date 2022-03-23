import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant_app/core/network/network_info.dart';
import 'package:restaurant_app/restaurant/data/datasources/restaurant_remote_data_sources.dart';
import 'package:restaurant_app/restaurant/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurant_app/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_app/restaurant/domain/usecases/get_restaurant_detail.dart';
import 'package:restaurant_app/restaurant/domain/usecases/get_restaurant_list.dart';
import 'package:restaurant_app/restaurant/domain/usecases/search_restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/restaurant/presentation/bloc/restaurant_detail/restaurant_detail_bloc.dart';
import 'package:restaurant_app/restaurant/presentation/bloc/restaurant_list/restaurant_bloc.dart';
import 'package:restaurant_app/restaurant/presentation/bloc/search_restaurant/bloc/search_restaurant_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerLazySingleton<RestaurantBloc>(
      () => RestaurantBloc(getRestaurantList: sl()));
  sl.registerFactory<RestaurantDetailBloc>(
      () => RestaurantDetailBloc(getRestaurantDetail: sl()));
  sl.registerFactory<SearchRestaurantBloc>(
      () => SearchRestaurantBloc(searchRestaurant: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetRestaurantList(repository: sl()));
  sl.registerLazySingleton(() => GetRestaurantDetail(repository: sl()));
  sl.registerLazySingleton(() => SearchRestaurant(repository: sl()));

  // Repository
  sl.registerLazySingleton<RestaurantRepository>(() =>
      RestaurantRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
      () => RestaurantRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
