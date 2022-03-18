import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomerReviews extends Equatable {
  final String name;
  final String review;
  final String date;
  const CustomerReviews({
    required this.name,
    required this.review,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'review': review,
      'date': date,
    };
  }

  factory CustomerReviews.fromMap(Map<String, dynamic> map) {
    return CustomerReviews(
      name: map['name'] ?? '',
      review: map['review'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory CustomerReviews.fromJson(String source) => CustomerReviews.fromMap(jsonDecode(source));

  @override
  List<Object> get props => [name, review, date];
}
