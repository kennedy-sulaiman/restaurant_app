import 'package:flutter/material.dart';
import 'package:restaurant_app/core/enum_picture_size.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant.dart';

import 'custom_list_item.dart';

class RestaurantListItem extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantListItem({required this.restaurant,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
      child: CustomListItem(
        picture: Container(
            height: 120,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                restaurant.getPicture(PictureSize.small),
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            )),
        name: restaurant.name,
        city: restaurant.city,
        rating: restaurant.rating,
        id: restaurant.id,
      ),
    );
  }
}
