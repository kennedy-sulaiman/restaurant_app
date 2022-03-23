part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();
  @override
  List<Object?> get props => [];
}

class GetRestaurantListEvent extends RestaurantEvent {}

class GetRestaurantDetailEvent extends RestaurantEvent {
  final String id;
  const GetRestaurantDetailEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}

class SearchRestaurantEvent extends RestaurantEvent {
  final String query;
  const SearchRestaurantEvent({
    required this.query,
  });
  
  @override
  List<Object?> get props => [query];
}
