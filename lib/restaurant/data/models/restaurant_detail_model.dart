import 'dart:convert';

import '../../domain/entities/restaurant_detail.dart';
import 'categories.dart';
import 'customer_reviews.dart';
import 'menus.dart';

class RestaurantDetailModel extends RestaurantDetail {
  const RestaurantDetailModel({
    required String id,
    required String name,
    required String description,
    required String city,
    required String address,
    required String pictureId,
    required List<Categories> categories,
    required Menus menus,
    required num rating,
    required List<CustomerReviews> customerReviews,
  }) : super(
            id: id,
            name: name,
            description: description,
            city: city,
            address: address,
            pictureId: pictureId,
            categories: categories,
            menus: menus,
            rating: rating,
            customerReviews: customerReviews);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'address': address,
      'pictureId': pictureId,
      'categories': categories.map((x) => x.toMap()).toList(),
      'menus': menus.toMap(),
      'rating': rating,
      'customerReviews': customerReviews.map((x) => x.toMap()).toList(),
    };
  }

  factory RestaurantDetailModel.fromMap(Map<String, dynamic> map) {
    return RestaurantDetailModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      city: map['city'] ?? '',
      address: map['address'] ?? '',
      pictureId: map['pictureId'] ?? '',
      categories: List<Categories>.from(
          map['categories']?.map((x) => Categories.fromMap(x))),
      menus: Menus.fromMap(map['menus']),
      rating: map['rating'] ?? 0,
      customerReviews: List<CustomerReviews>.from(
          map['customerReviews']?.map((x) => CustomerReviews.fromMap(x))),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory RestaurantDetailModel.fromJson(String source) =>
      RestaurantDetailModel.fromMap(jsonDecode(source));
}
