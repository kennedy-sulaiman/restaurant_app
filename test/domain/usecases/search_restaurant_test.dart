import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant.dart';
import 'package:restaurant_app/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_app/restaurant/domain/usecases/get_restaurant_detail.dart';
import 'package:restaurant_app/restaurant/domain/usecases/params.dart';
import 'package:restaurant_app/restaurant/domain/usecases/search_restaurant.dart';

class MockSearchRestaurantRepository extends Mock
    implements RestaurantRepository {}

void main() {
  late MockSearchRestaurantRepository mockSearchRestaurantRepository;
  late SearchRestaurant usecase;

  setUpAll(() {
    mockSearchRestaurantRepository = MockSearchRestaurantRepository();
    usecase = SearchRestaurant(repository: mockSearchRestaurantRepository);
  });

  final tRestaurantList = <Restaurant>[];
  test('should search for spesific restaurant', () async {
    when(() => mockSearchRestaurantRepository.searchRestaurant(any()))
        .thenAnswer((invocation) async => Right(tRestaurantList));
    final result = await usecase(const Params(name: "name"));

    expect(result, Right(tRestaurantList));

    verify(() => mockSearchRestaurantRepository.searchRestaurant(any()));
    verifyNoMoreInteractions(mockSearchRestaurantRepository);
  });
}
