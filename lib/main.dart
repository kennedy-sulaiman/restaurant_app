import 'package:flutter/material.dart';
import 'package:restaurant_app/restaurant/RestaurantDetail.dart';
import 'package:restaurant_app/restaurant/RestaurantList.dart';
import 'package:restaurant_app/restaurant/Restaurants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Restaurant App",
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'Roboto'),
      initialRoute: RestaurantList.routeName,
      routes: {
        RestaurantList.routeName: ((context) => const RestaurantList()),
        RestaurantDetail.routeName: ((context) => RestaurantDetail(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant)),
      },
    );
  }
}
