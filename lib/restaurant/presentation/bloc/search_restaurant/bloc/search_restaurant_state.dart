part of 'search_restaurant_bloc.dart';

abstract class SearchRestaurantState extends Equatable {
  const SearchRestaurantState();

  @override
  List<Object?> get props => [];
}

class SearchRestaurantInitial extends SearchRestaurantState {
  const SearchRestaurantInitial();
}

class SearchRestaurantLoading extends SearchRestaurantState {
  const SearchRestaurantLoading();
}

class SearchRestaurantLoaded extends SearchRestaurantState {
  final List<Restaurant> restaurant;
  const SearchRestaurantLoaded({required this.restaurant});

  @override
  List<Object?> get props => [restaurant];
}
class ErrorState extends SearchRestaurantState {
  final String message;
  const ErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}