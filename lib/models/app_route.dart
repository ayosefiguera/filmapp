import 'package:flutter/cupertino.dart';

class AppRoute {
  final String route;
  final String name;
  final Widget screen;
  final IconData icon;

  AppRoute(
      {required this.route,
      required this.name,
      required this.screen,
      required this.icon});
}
