import 'package:flutter/material.dart';

class RestaurantInformation extends StatelessWidget {
  final String name;
  final String city;
  final num rating;

  const RestaurantInformation(
      {Key? key, required this.name, required this.city, required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18.0)),
            ),
            const SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.room_outlined),
                const Padding(padding: EdgeInsets.only(right: 3.0)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Text(
                    city,
                    style: const TextStyle(
                        fontWeight: FontWeight.w200, fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.star_outline),
                const Padding(padding: EdgeInsets.only(right: 3.0)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  child: Text(
                    rating.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w200, fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
