import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/enum_picture_size.dart';
import 'package:restaurant_app/restaurant/data/models/foods_and_drinks.dart';
import 'package:restaurant_app/restaurant/presentation/widget/loading_widget.dart';
import 'package:restaurant_app/restaurant/presentation/widget/my_alert_dialog.dart';

import '../../../injection.dart';
import '../../domain/entities/restaurant_detail.dart';
import '../bloc/restaurant_detail/restaurant_detail_bloc.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String id;
  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context, id);
  }
}

BlocProvider<RestaurantDetailBloc> _buildBody(BuildContext context, String id) {
  return BlocProvider(create: (_) {
    return sl<RestaurantDetailBloc>();
  }, child: BlocBuilder<RestaurantDetailBloc, RestaurantDetailState>(
    builder: (context, state) {
      if (state is RestaurantDetailInitial) {
        context
            .read<RestaurantDetailBloc>()
            .add(GetRestaurantDetailEvent(id: id));
      } else if (state is RestaurantDetailLoading) {
        const LoadingWidget();
      } else if (state is RestaurantDetailLoaded) {
        final detail = state.restaurantDetail;
        return DetailContent(restaurant: detail);
      } else if (state is ErrorState) {
        return MyAlertDialog(
            message: state.message,
            title: "Oops!!",
            coolAlertType: CoolAlertType.error);
      }
      return const MyAlertDialog(
          message: "Something wrong",
          title: "State Status",
          coolAlertType: CoolAlertType.error);
    },
  ));
}

class DetailContent extends StatelessWidget {
  final RestaurantDetail restaurant;
  const DetailContent({required this.restaurant, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(restaurant.name),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
                top: 10.0, right: 10.0, left: 10.0, bottom: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      restaurant.getPicture(PictureSize.large),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(19.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: const TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.room_outlined),
                            const Padding(padding: EdgeInsets.only(right: 3.0)),
                            Text(
                              restaurant.city,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        _subtitleText("Description"),
                        const SizedBox(height: 15),
                        Text(
                          "\t\t\t\t" + restaurant.description,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 30),
                        _subtitleText("Menus"),
                        const SizedBox(height: 15.0),
                        _subtitleText("Foods"),
                        _menusGridView(restaurant.menus.foods),
                        const SizedBox(height: 15.0),
                        _subtitleText("Drinks"),
                        _menusGridView(restaurant.menus.drinks)
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}

Widget _subtitleText(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
  );
}

Widget _menusGridView(List product) {
  return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: product.length,
      itemBuilder: (BuildContext context, int index) {
        return _menusItemList(product[index]);
      });
}

Widget _menusItemList(FoodsAndDrinks food) {
  return InkWell(
    child: Card(
        margin: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        color: Colors.blueAccent,
                      )),
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                  flex: 1,
                  child: Text(
                    food.name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w100),
                  ))
            ],
          ),
        )),
    onTap: () {},
  );
}
