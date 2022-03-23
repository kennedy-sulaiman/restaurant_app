import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection.dart';
import '../../domain/entities/restaurant.dart';
import '../bloc/search_restaurant/bloc/search_restaurant_bloc.dart';
import '../widget/loading_widget.dart';
import '../widget/my_alert_dialog.dart';
import '../widget/restaurant_list_item.dart';

class SearchRestaurantPage extends StatelessWidget {
  static const routeName = '/search_page';
  final String query;
  const SearchRestaurantPage({required this.query, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Find My Restaurant"),
          centerTitle: true,
        ),
        body: _buildBody(context, query));
  }
}

BlocProvider<SearchRestaurantBloc> _buildBody(BuildContext context, String query) {
  return BlocProvider(
    create: (_) => sl<SearchRestaurantBloc>(),
    child: BlocBuilder<SearchRestaurantBloc, SearchRestaurantState>(
      builder: (context, state) {
        if (state is SearchRestaurantInitial) {
          context
              .read<SearchRestaurantBloc>()
              .add(SearchForRestaurantEvent(query: query));
        } else if (state is SearchRestaurantLoading) {
          return const LoadingWidget();
        } else if (state is SearchRestaurantLoaded) {
          return SearchContent(restaurants: state.restaurant);
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
      },
    ),
  );
}

class SearchContent extends StatelessWidget {
  final List<Restaurant> restaurants;
  const SearchContent({required this.restaurants, Key? key}) : super(key: key);

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
