import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/restaurant/domain/usecases/get_restaurant_detail.dart';

import '../../../domain/entities/restaurant_detail.dart';
import '../../../domain/usecases/params.dart';
import '../restaurant_list/restaurant_bloc.dart';

part 'restaurant_detail_event.dart';
part 'restaurant_detail_state.dart';

class RestaurantDetailBloc
    extends Bloc<RestaurantDetailEvent, RestaurantDetailState> {
  final GetRestaurantDetail getRestaurantDetail;
  RestaurantDetailBloc({required this.getRestaurantDetail}) : super(const RestaurantDetailInitial()) {
    on<GetRestaurantDetailEvent>((event, emit) async {
      emit(const RestaurantDetailLoading());
      final result = await getRestaurantDetail(Params(name: event.id));
      await result.fold(
          (failure) async => emit(const ErrorState(message: SERVER_FAILURES)),
          (restaurantDetail) async =>
              emit(RestaurantDetailLoaded(restaurantDetail: restaurantDetail)));
    });
  }
}
