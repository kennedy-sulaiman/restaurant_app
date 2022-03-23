import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/core/usecases/usecase.dart';
import 'package:restaurant_app/restaurant/domain/repositories/restaurant_repository.dart';
import 'package:restaurant_app/restaurant/domain/usecases/get_restaurant_detail.dart';
import 'package:restaurant_app/restaurant/domain/usecases/params.dart';

import '../../fixtures/common.dart';

class MockGetRestaurantDetailRepository extends Mock
    implements RestaurantRepository {}

void main() {
  late MockGetRestaurantDetailRepository mockGetRestaurantDetailRepository;
  late GetRestaurantDetail usecase;

  setUpAll(() {
    mockGetRestaurantDetailRepository = MockGetRestaurantDetailRepository();
    usecase =
        GetRestaurantDetail(repository: mockGetRestaurantDetailRepository);
  });

  test("should get restaurant detail from repository", () async {
    when(() => mockGetRestaurantDetailRepository.getRestaurantDetail(any()))
        .thenAnswer((invocation) async => const Right(tRestaurantDetail));
    final result = await usecase(const Params(name: "rqdv5juczeskfw1e867"));

    expect(result, const Right(tRestaurantDetail));

    verify(() => mockGetRestaurantDetailRepository.getRestaurantDetail("rqdv5juczeskfw1e867"));
    verifyNoMoreInteractions(mockGetRestaurantDetailRepository);
  });
}
