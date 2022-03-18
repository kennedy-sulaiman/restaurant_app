import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'foods_and_drinks.dart';

class Menus extends Equatable {
  final List<FoodsAndDrinks> foods;
  final List<FoodsAndDrinks> drinks;
  const Menus({
    required this.foods,
    required this.drinks,
  });

  @override
  List<Object> get props => [foods, drinks];

  Map<String, dynamic> toMap() {
    return {
      'foods': foods.map((x) => x.toMap()).toList(),
      'drinks': drinks.map((x) => x.toMap()).toList(),
    };
  }

  factory Menus.fromMap(Map<String, dynamic> map) {
    return Menus(
      foods: List<FoodsAndDrinks>.from(map['foods']?.map((x) => FoodsAndDrinks.fromMap(x))),
      drinks: List<FoodsAndDrinks>.from(map['drinks']?.map((x) => FoodsAndDrinks.fromMap(x))),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Menus.fromJson(String source) => Menus.fromMap(jsonDecode(source));
}
