import 'package:equatable/equatable.dart';

import '../../../core/enum_picture_size.dart';
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

  String getPicture(PictureSize size) {
    switch (size) {
      case PictureSize.small:
        return "https://restaurant-api.dicoding.dev/images/small/$pictureId";
      case PictureSize.medium:
        return "https://restaurant-api.dicoding.dev/images/medium/$pictureId";
      case PictureSize.large:
        return "https://restaurant-api.dicoding.dev/images/large/$pictureId";
    }
  }

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