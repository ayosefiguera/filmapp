import 'package:flutter/material.dart';

import 'package:fl_filmapp/models/models.dart';
import 'dev_config.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _ApiKey = DevConfig.apiDev;
  final String _BaseUrl = 'api.themoviedb.org';
  final String _Segment_Now = '3/movie/now_playing';
  final String _Segment_Popular = '3/movie/popular';
  final String _Language = 'es-ES';
  final String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> onDisplayPopularMovies = [];

  MoviesProvider() {
    getNowDislpayMovies();
    getPopularPlayMovies();
  }

  getNowDislpayMovies() async {
    var url = Uri.http(_BaseUrl, _Segment_Now, {
      'api_key': _ApiKey,
      'language': _Language,
      'page': _page,
    });

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayinResponse.fromJson(response.body);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularPlayMovies() async {
    var url = Uri.http(_BaseUrl, _Segment_Popular,
        {'api_key': _ApiKey, 'language': _Language, 'page': _page});

    final response = await http.get(url);
    final popularMoviesResponse = PopularMoviesResponse.fromJson(response.body);
    onDisplayPopularMovies = [...onDisplayPopularMovies, ...popularMoviesResponse.results];
    notifyListeners();
  }
}
