import 'dart:convert';

import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  final String name;
  const Categories({
    required this.name,
  });

  @override
  List<Object> get props => [name];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      name: map['name'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Categories.fromJson(String source) =>
      Categories.fromMap(jsonDecode(source));
}
