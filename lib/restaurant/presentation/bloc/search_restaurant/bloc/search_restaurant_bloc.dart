import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/restaurant/domain/usecases/search_restaurant.dart';

import '../../../../domain/entities/restaurant.dart';
import '../../../../domain/usecases/params.dart';
import '../../restaurant_list/restaurant_bloc.dart';

part 'search_restaurant_event.dart';
part 'search_restaurant_state.dart';

class SearchRestaurantBloc
    extends Bloc<SearchRestaurantEvent, SearchRestaurantState> {
  final SearchRestaurant searchRestaurant;
  SearchRestaurantBloc({required this.searchRestaurant}) : super(const SearchRestaurantInitial()) {
    on<SearchForRestaurantEvent>((event, emit) async {
      emit(const SearchRestaurantLoading());
      final result = await searchRestaurant(Params(name: event.query));
      await result.fold(
          (failure) async => emit(const ErrorState(message: SERVER_FAILURES)),
          (search) async => emit(SearchRestaurantLoaded(restaurant: search)));
    });
  }
}
