import 'dart:convert';

class Restaurants {
  late List<Restaurant> restaurant;

  Restaurants({required this.restaurant});

  Restaurants.fromJson(Map<String, dynamic> data) {
    final restaurantData = data["restaurants"] as List<dynamic>;
    restaurant = restaurantData.map((e) => Restaurant.fromJson(e)).toList();
  }
}

class Restaurant {
  late String id;
  late String name;
  late String desc;
  late String picId;
  late String city;
  late num rating;
  late Menus menus;

  Restaurant(
      {required this.id,
      required this.name,
      required this.desc,
      required this.picId,
      required this.city,
      required this.rating,
      required this.menus});

  Restaurant.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    desc = data["description"];
    picId = data["pictureId"];
    city = data["city"];
    rating = data["rating"];
    menus = Menus.fromJson(data["menus"]);
  }
}

class Menus {
  late List<Food> foods;
  late List<Food> drinks;

  Menus({required this.foods, required this.drinks});

  Menus.fromJson(Map<String, dynamic> data) {
    foods = List<Food>.from(data["foods"].map((x) => Food.fromJson(x)));
    drinks = List<Food>.from(data["drinks"].map((x) => Food.fromJson(x)));
  }
}

class Food {
  late String name;

  Food({required this.name});

  Food.fromJson(Map<String, dynamic> data) {
    name = data["name"];
  }
}
