import 'dart:convert';

import 'package:equatable/equatable.dart';

class FoodsAndDrinks extends Equatable {
  final String name;
  const FoodsAndDrinks({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory FoodsAndDrinks.fromMap(Map<String, dynamic> map) {
    return FoodsAndDrinks(
      name: map['name'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory FoodsAndDrinks.fromJson(String source) => FoodsAndDrinks.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [name];
}
