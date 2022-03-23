import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataChecker;

  setUpAll(() {
    mockDataChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(connectionChecker: mockDataChecker);
  });

  group('Network is Connected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      final tHasConnectionFuture = Future.value(true);

      when(() => mockDataChecker.hasConnection)
          .thenAnswer((invocation) => tHasConnectionFuture);
      final result = networkInfo.isConnected;
      expect(identical(result, tHasConnectionFuture), true);
    });
  });
}
