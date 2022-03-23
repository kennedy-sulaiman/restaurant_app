import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/injection.dart';
import 'package:restaurant_app/restaurant/presentation/bloc/restaurant_list/restaurant_bloc.dart';
import 'package:restaurant_app/restaurant/presentation/widget/my_alert_dialog.dart';
import 'package:restaurant_app/restaurant/presentation/widget/my_widgets.dart';

import '../../domain/entities/restaurant.dart';
import 'search_restaurant_page.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  Widget customSearchBar = const Text("Restaurant App");
  Icon customIcon = const Icon(Icons.search);
  late String query;

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
                      customSearchBar = SizedBox(
                        height: 40,
                        width: 400,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              query = value;
                            });
                          },
                          onSubmitted: (_) {
                            Navigator.pushNamed(
                                context, SearchRestaurantPage.routeName,
                                arguments: query);
                          },
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
        body: _buildBody(context));
  }
}

BlocProvider<RestaurantBloc> _buildBody(BuildContext context) {
  return BlocProvider(
    create: (_) => sl<RestaurantBloc>(),
    child: BlocBuilder<RestaurantBloc, RestaurantState>(
        bloc: sl<RestaurantBloc>(),
        builder: ((context, state) {
          if (state is InitialState) {
            context.read<RestaurantBloc>().add(GetRestaurantListEvent());
          } else if (state is LoadingState) {
            return const LoadingWidget();
          } else if (state is LoadedState) {
            return ListContent(restaurants: state.restaurant);
          } else if (state is ErrorState) {
            return MyAlertDialog(
                message: state.message,
                title: "Error",
                coolAlertType: CoolAlertType.error);
          }
          return const MyAlertDialog(
              message: "Something wrong",
              title: "State Status",
              coolAlertType: CoolAlertType.error);
        })),
  );
}

class ListContent extends StatelessWidget {
  final List<Restaurant> restaurants;
  const ListContent({required this.restaurants, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        final restaurant = restaurants[index];
        return RestaurantListItem(restaurant: restaurant);
      }),
      itemCount: restaurants.length,
    );
  }
}
