part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState extends Equatable {
  const RestaurantState();
  @override
  List<Object?> get props => [];
}

class InitialState extends RestaurantState {
  const InitialState();
}

class LoadingState extends RestaurantState {
  const LoadingState();
}

class LoadedState extends RestaurantState {
  final List<Restaurant> restaurant;
  const LoadedState({required this.restaurant});

  @override
  List<Object?> get props => [restaurant];
}

class ErrorState extends RestaurantState {
  final String message;
  const ErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
