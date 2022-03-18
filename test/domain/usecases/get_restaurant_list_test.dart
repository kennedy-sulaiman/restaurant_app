import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/core/usecases/usecase.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant.dart';
import 'package:restaurant_app/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_app/restaurant/domain/usecases/get_restaurant_list.dart';

import '../../fixtures/common.dart';

class MockGetRestaurantListRepository extends Mock
    implements RestaurantRepository {}

void main() {
  late MockGetRestaurantListRepository mockGetRestaurantListRepository;
  late GetRestaurantList usecase;

  setUpAll(() {
    mockGetRestaurantListRepository = MockGetRestaurantListRepository();
    usecase = GetRestaurantList(repository: mockGetRestaurantListRepository);
  });

  final tRestaurantList = <Restaurant>[];

  test('should get restaurant list from repository', () async {
    when(() => mockGetRestaurantListRepository.getRestaurantList())
        .thenAnswer((invocation) async => Right(tRestaurantList));

    final result = await usecase(const NoParams());

    expect(result, Right(tRestaurantList));

    verify(() => mockGetRestaurantListRepository.getRestaurantList());
    verifyNoMoreInteractions(mockGetRestaurantListRepository);
  });
}
