part of 'restaurant_detail_bloc.dart';

abstract class RestaurantDetailState extends Equatable {
  const RestaurantDetailState();

  @override
  List<Object> get props => [];
}

class RestaurantDetailInitial extends RestaurantDetailState {
  const RestaurantDetailInitial();
}

class RestaurantDetailLoading extends RestaurantDetailState {
  const RestaurantDetailLoading();
}

class RestaurantDetailLoaded extends RestaurantDetailState {
  final RestaurantDetail restaurantDetail;
  const RestaurantDetailLoaded({
    required this.restaurantDetail,
  });

  @override
  List<Object> get props => [restaurantDetail];
}

class ErrorState extends RestaurantDetailState {
  final String message;
  const ErrorState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
