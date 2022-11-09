import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fl_filmapp/themes/app_theme.dart';
import 'package:fl_filmapp/providers/provider.dart';
import 'package:fl_filmapp/routes/app_routes.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilmApp',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      theme: AppTheme.baseTheme,
    );
  }
}
