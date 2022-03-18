import 'dart:convert';

import 'package:restaurant_app/restaurant/domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required String id,
    required String name,
    required String description,
    required String pictureId,
    required String city,
    required num rating,
  }) : super (
    id: id,
    name: name,
    description: description,
    pictureId: pictureId,
    city: city,
    rating: rating
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      pictureId: map['pictureId'] ?? '',
      city: map['city'] ?? '',
      rating: map['rating'] ?? 0,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory RestaurantModel.fromJson(String source) =>
      RestaurantModel.fromMap(jsonDecode(source));
}
