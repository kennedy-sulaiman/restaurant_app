import 'package:flutter/material.dart';
import '../pages/restaurant_detail_page.dart';
import 'restaurant_information.dart';

class CustomListItem extends StatelessWidget {
  final Widget picture;
  final String name;
  final String city;
  final num rating;
  final String id;

  const CustomListItem(
      {Key? key,
      required this.picture,
      required this.name,
      required this.city,
      required this.rating,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(right: 5.0, top: 5.0),
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10.0),
        child: Row(
          children: [
            Expanded(flex: 1, child: picture),
            Expanded(
                flex: 2,
                child: RestaurantInformation(
                    name: name, city: city, rating: rating))
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: id);
      },
    );
  }
}
