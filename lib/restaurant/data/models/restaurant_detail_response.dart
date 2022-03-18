import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'restaurant_detail_model.dart';

class RestaurantDetailModelResponse extends Equatable {
  final RestaurantDetailModel restaurant;
  const RestaurantDetailModelResponse({
    required this.restaurant,
  });

  @override
  List<Object> get props => [restaurant];

  

  Map<String, dynamic> toMap() {
    return {
      'restaurant': restaurant.toMap(),
    };
  }

  factory RestaurantDetailModelResponse.fromMap(Map<String, dynamic> map) {
    return RestaurantDetailModelResponse(
      restaurant: RestaurantDetailModel.fromMap(map['restaurant']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantDetailModelResponse.fromJson(String source) => RestaurantDetailModelResponse.fromMap(json.decode(source));
}
