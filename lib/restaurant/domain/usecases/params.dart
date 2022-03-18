import 'package:equatable/equatable.dart';

class Params extends Equatable {
  final String name;
  const Params({
    required this.name,
  });
  

  @override
  List<Object> get props => [name];
}
