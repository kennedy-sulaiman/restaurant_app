import 'package:flutter/material.dart';
import 'package:restaurant_app/restaurant/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/restaurant/presentation/pages/restaurant_list_page.dart';
import 'package:restaurant_app/restaurant/domain/entities/restaurant.dart';
import 'package:restaurant_app/injection.dart' as di;
import 'package:restaurant_app/restaurant/presentation/pages/search_restaurant_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Restaurant App",
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'Roboto'),
      home: const RestaurantListPage(),
      navigatorObservers: [RouteObserver()],
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(
                builder: (_) => const RestaurantListPage());
          case RestaurantDetailPage.routeName:
            final id = settings.arguments as String;
            return MaterialPageRoute(
                builder: (_) => RestaurantDetailPage(
                      id: id,
                    ),
                settings: settings);
          case SearchRestaurantPage.routeName:
            final query = settings.arguments as String;
            return MaterialPageRoute(
                builder: (_) => SearchRestaurantPage(query: query),
                settings: settings);
          default:
            return MaterialPageRoute(builder: (_) {
              return const Scaffold(
                body: Center(
                  child: Text('Page not found :('),
                ),
              );
            });
        }
      },
    );
  }
}
