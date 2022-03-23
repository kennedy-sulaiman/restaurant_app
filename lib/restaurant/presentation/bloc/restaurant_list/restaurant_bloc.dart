import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_app/core/usecases/usecase.dart';
import 'package:restaurant_app/restaurant/domain/usecases/get_restaurant_list.dart';

import '../../../domain/entities/restaurant.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

const SERVER_FAILURES = "Server Failure";

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final GetRestaurantList getRestaurantList;
  RestaurantBloc(
      {
      required this.getRestaurantList,})
      : super(const InitialState()) {
    on<GetRestaurantListEvent>((event, emit) async {
      emit(const LoadingState());
      final result = await getRestaurantList(const NoParams());

      await result.fold(
          (failure) async => emit(const ErrorState(message: SERVER_FAILURES)),
          (restaurant) async => emit(LoadedState(restaurant: restaurant)));
    });
    
  }
}
