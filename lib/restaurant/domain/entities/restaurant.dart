import 'dart:convert';

import 'package:equatable/equatable.dart';

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
