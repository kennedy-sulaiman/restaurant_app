part of 'restaurant_detail_bloc.dart';

abstract class RestaurantDetailEvent extends Equatable {
  const RestaurantDetailEvent();

  @override
  List<Object> get props => [];
}

class GetRestaurantDetailEvent extends RestaurantDetailEvent {
  final String id;
  const GetRestaurantDetailEvent({
    required this.id,
  });
  @override
  List<Object> get props => [id];
}
