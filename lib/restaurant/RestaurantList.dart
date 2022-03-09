import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/restaurant/RestaurantDetail.dart';
import 'Restaurants.dart';

class RestaurantList extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantList({Key? key}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  Widget customSearchBar = const Text("Restaurant App");
  Icon customIcon = const Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = Container(
                      height: 40,
                      width: 400,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(300.0)),
                            hintText: "search restaurant . . .",
                            hintStyle: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                            )),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text("Restaurant App");
                  }
                });
              },
              icon: customIcon)
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/local_restaurant.json'),
          builder: (context, snapshot) {
            final List<Restaurant> restaurants = parseJson(snapshot.data);
            if (restaurants.isEmpty) {
              return const Text("Data JSON Failed to Load",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500));
            }
            return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return _restaurantListItem(context, restaurants[index]);
                });
          }),
    );
  }
}

List<Restaurant> parseJson(String? json) {
  if (json == null) {
    return [];
  }

  final parsed = jsonDecode(json);

  final restaurant = Restaurants.fromJson(parsed);

  return restaurant.restaurant;
}

Widget _restaurantListItem(BuildContext context, Restaurant restaurant) {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
    child: _CustomListItem(
      picture: Container(
          height: 120,
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              restaurant.picId,
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
          )),
      name: restaurant.name,
      city: restaurant.city,
      rating: restaurant.rating,
      restaurant: restaurant,
    ),
  );
}

class _CustomListItem extends StatelessWidget {
  final Widget picture;
  final String name;
  final String city;
  final num rating;
  final Restaurant restaurant;

  const _CustomListItem(
      {Key? key,
      required this.picture,
      required this.name,
      required this.city,
      required this.rating,
      required this.restaurant})
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
                child: _RestaurantInformation(
                    name: name, city: city, rating: rating))
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetail.routeName,
            arguments: restaurant);
      },
    );
  }
}

class _RestaurantInformation extends StatelessWidget {
  final String name;
  final String city;
  final num rating;

  const _RestaurantInformation(
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
