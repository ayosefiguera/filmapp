import 'package:fl_filmapp/providers/provider.dart';
import 'package:fl_filmapp/search/search_delegate.dart';
import 'package:flutter/material.dart';

import 'package:fl_filmapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('FilmApp'), actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () =>
              showSearch(context: context, delegate: MovieSearchDelagate()),
        ),
      ]),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CardSwiper(movies: moviesProvider.onDisplayMovies),
        MoviSlider(
          movies: moviesProvider.onDisplayPopularMovies,
          title: 'Popular',
          onNextPage: () => moviesProvider.getPopularPlayMovies(),
        )
      ]),
    );
  }
}
