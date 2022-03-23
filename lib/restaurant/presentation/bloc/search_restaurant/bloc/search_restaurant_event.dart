part of 'search_restaurant_bloc.dart';

abstract class SearchRestaurantEvent extends Equatable {
  const SearchRestaurantEvent();

  @override
  List<Object> get props => [];
}

class SearchForRestaurantEvent extends SearchRestaurantEvent {
  final String query;
  const SearchForRestaurantEvent({
    required this.query,
  });
  
  @override
  List<Object> get props => [query];
}
