import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/enum_picture_size.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
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
      pictureId,
      city,
      rating,
    ];
  }
}
