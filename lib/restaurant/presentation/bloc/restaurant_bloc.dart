import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<RestaurantEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
