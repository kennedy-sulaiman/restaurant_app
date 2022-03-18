import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:restaurant_app/restaurant/data/models/restaurant_model.dart';

class RestaurantResponse extends Equatable {
  final List<RestaurantModel> restaurantList;
  const RestaurantResponse({
    required this.restaurantList,
  });

  @override
  List<Object> get props => [restaurantList];

  Map<String, dynamic> toMap() {
    return {
      'restaurants': restaurantList.map((x) => x.toMap()).toList(),
    };
  }

  factory RestaurantResponse.fromMap(Map<String, dynamic> map) {
    return RestaurantResponse(
      restaurantList: List<RestaurantModel>.from(map['restaurants']?.map((x) => RestaurantModel.fromMap(x))),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory RestaurantResponse.fromJson(String source) => RestaurantResponse.fromMap(jsonDecode(source));
}
