import 'package:fl_filmapp/models/models.dart';
import 'package:fl_filmapp/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'home';
  static final _screenRoutes = <AppRoute>[
    AppRoute(
        route: 'home',
        name: 'Home',
        screen: const HomeScreen(),
        icon: Icons.home_outlined),
    AppRoute(
        route: 'detail',
        name: 'Detail',
        screen: const DetailsScreen(),
        icon: Icons.details_outlined)
  ];

// This method creates and returns a Map <String, Widget> to obtain a relation of routes and screens to navigate through.

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (var option in _screenRoutes) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }
}
