import 'package:equatable/equatable.dart';

import '../../data/models/categories.dart';
import '../../data/models/customer_reviews.dart';
import '../../data/models/menus.dart';

class RestaurantDetail extends Equatable {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Categories> categories;
  final Menus menus;
  final num rating;
  final List<CustomerReviews> customerReviews;

  const RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      city,
      address,
      pictureId,
      categories,
      menus,
      rating,
      customerReviews,
    ];
  }
}