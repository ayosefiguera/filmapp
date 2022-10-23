import 'package:flutter/material.dart';

import 'package:fl_filmapp/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FilmApp'), actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ]),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [CardSwiper(), MoviSlider()]),
    );
  }
}
