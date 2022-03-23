import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/core/error/failure.dart';
import 'package:restaurant_app/core/usecases/usecase.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant.dart';
import 'package:restaurant_app/restaurant/domain/usecases/get_restaurant_detail.dart';
import 'package:restaurant_app/restaurant/domain/usecases/get_restaurant_list.dart';
import 'package:restaurant_app/restaurant/domain/usecases/params.dart';
import 'package:restaurant_app/restaurant/domain/usecases/search_restaurant.dart';
import 'package:restaurant_app/restaurant/presentation/bloc/restaurant_list/restaurant_bloc.dart';

class MockGetRestaurantList extends Mock implements GetRestaurantList {}

class MockGetRestaurantDetail extends Mock implements GetRestaurantDetail {}

class MockSearchRestaurant extends Mock implements SearchRestaurant {}

void main() {
  late RestaurantBloc bloc;
  late MockGetRestaurantList getRestaurantList;
  late MockSearchRestaurant searchRestaurant;

  setUpAll(() {
    getRestaurantList = MockGetRestaurantList();
    searchRestaurant = MockSearchRestaurant();

    registerFallbackValue(const Params(name: "rqdv5juczeskfw1e867"));
    registerFallbackValue(const Params(name: "Makan mudah"));
    registerFallbackValue(const NoParams());

    bloc = RestaurantBloc(
        getRestaurantList: getRestaurantList);
  });

  test('initial state must empty', () {
    expect(bloc.state, const InitialState());
  });

  group('Get Restaurant List', () {
    final tRestaurants = <Restaurant>[];
    blocTest<RestaurantBloc, RestaurantState>(
      'emits [Loading, Loaded] when GetRestaurantListEvent is added.',
      build: () {
        when(() => getRestaurantList(any()))
            .thenAnswer((invocation) async => Right(tRestaurants));
        return bloc;
      },
      act: (bloc) => bloc.add(GetRestaurantListEvent()),
      expect: () => <RestaurantState>[
        const LoadingState(),
        LoadedState(restaurant: tRestaurants)
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [Loading, Error] when GetRestaurantListEvent is added.',
      build: () {
        when(() => getRestaurantList(any()))
            .thenAnswer((invocation) async => Left(ServerFailures()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetRestaurantListEvent()),
      expect: () => const <RestaurantState>[
        LoadingState(),
        ErrorState(message: SERVER_FAILURES)
      ],
    );
  });

  group('search restaurant', () {
    final String query = "Makan mudah";
    final tSearchedRestaurant = <Restaurant>[];
    blocTest<RestaurantBloc, RestaurantState>(
      'emits [Loading, Loaded] when SearchRestaurantEvent is added.',
      build: () {
        when(() => searchRestaurant(any()))
            .thenAnswer((invocation) async => Right(tSearchedRestaurant));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchRestaurantEvent(query: query)),
      expect: () => <RestaurantState>[
        const LoadingState(),
        LoadedState(restaurant: tSearchedRestaurant)
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [Loading, Error] when SearchRestaurantEvent is added.',
      build: () {
        when(() => searchRestaurant(any()))
            .thenAnswer((invocation) async => Left(ServerFailures()));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchRestaurantEvent(query: query)),
      expect: () => const <RestaurantState>[
        LoadingState(),
        ErrorState(message: SERVER_FAILURES)
      ],
    );
  });
}
