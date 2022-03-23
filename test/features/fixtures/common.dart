import 'package:restaurant_app/restaurant/data/models/categories.dart';
import 'package:restaurant_app/restaurant/data/models/customer_reviews.dart';
import 'package:restaurant_app/restaurant/data/models/foods_and_drinks.dart';
import 'package:restaurant_app/restaurant/data/models/menus.dart';
import 'package:restaurant_app/restaurant/data/models/restaurant_detail_model.dart';
import 'package:restaurant_app/restaurant/data/models/restaurant_model.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant_detail.dart';

const tRestaurant = Restaurant(
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
    pictureId: "14",
    city: "Medan",
    rating: 4.2);

const tRestaurantDetail = RestaurantDetail(
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
    city: "Medan",
    address: "Jln. Pandeglang no 19",
    pictureId: "14",
    categories: [categories1, categories2],
    menus: menus,
    rating: 4.2,
    customerReviews: customerReviews);

const tRestaurantModel = RestaurantModel(
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
    pictureId: "14",
    city: "Medan",
    rating: 4.2);

const tRestaurantDetailModel = RestaurantDetailModel(
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
    city: "Medan",
    address: "Jln. Pandeglang no 19",
    pictureId: "14",
    categories: [categories1, categories2],
    menus: menus,
    rating: 4.2,
    customerReviews: customerReviews);

const Categories categories1 = Categories(name: "Italia");
const Categories categories2 = Categories(name: "Modern");

const Menus menus = Menus(foods: foods, drinks: drinks);

const List<FoodsAndDrinks> foods = [
  FoodsAndDrinks(name: "Paket rosemary"),
  FoodsAndDrinks(name: "Toastie salmon")
];

const List<FoodsAndDrinks> drinks = [
  FoodsAndDrinks(name: "Es krim"),
  FoodsAndDrinks(name: "Sirup")
];

const List<CustomerReviews> customerReviews = [
  CustomerReviews(
      name: "Ahmad",
      review: "Tidak rekomendasi untuk pelajar!",
      date: "13 November 2019"),
];
