import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class ServerFailures extends Failure {}

class CacheFailures extends Failure {}
