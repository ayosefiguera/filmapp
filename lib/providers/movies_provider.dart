import 'dart:async';

import 'package:fl_filmapp/helpers/debouncer.dart';
import 'package:fl_filmapp/models/search.dart';
import 'package:flutter/material.dart';
import 'package:fl_filmapp/models/models.dart';
import '__config.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  final String _ApiKey = DevConfig.apiDev;
  // ignore: non_constant_identifier_names
  final String _BaseUrl = 'api.themoviedb.org';
  // ignore: non_constant_identifier_names
  final String _Language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onDisplayPopularMovies = [];

  Movie? ondDisplayMovie;

  Map<int, List<Cast>> movieCast = {};

  final StreamController<List<Movie>> _suggestionStreamController =
      new StreamController.broadcast();

  final debouncer =
      Debouncer(duration: Duration(milliseconds: 500), onValue: ((value) {}));

  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamController.stream;

  // ignore: unused_field
  int _popularpage = 0;

  MoviesProvider() {
    getNowDislpayMovies();
    getPopularPlayMovies();
  }

  Future<String> _getJsonData(String segment,
      {page = 1, isPages = true}) async {
    final url = Uri.http(_BaseUrl, segment, {
      'api_key': _ApiKey,
      'language': _Language,
      if (isPages) 'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getNowDislpayMovies() async {
    const String segmet =
        '3/movie/now_playing'; //Segment of Api needed to get the last movies
    final jsonData = await _getJsonData(segmet);
    final nowPlayingResponse = NowPlayinResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularPlayMovies() async {
    _popularpage++;
    const String segmet =
        '3/movie/popular'; //Segment of Api needed to get the popular movies

    final jsonData = await _getJsonData(segmet);

    final popularMoviesResponse = PopularMoviesResponse.fromJson(jsonData);
    onDisplayPopularMovies = [
      ...onDisplayPopularMovies,
      ...popularMoviesResponse.results
    ];
    notifyListeners();
  }
/*
  getMovie(String id) async {
    final movieId = id;
    final String segmet = '3/movie/$movieId';
    final jsonData = await _getJsonData(segmet, isPages: false);
    final ondDisplayMovie = Movie.fromJson(jsonData);
    notifyListeners();
  }*/

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

    final String segmet =
        '3/movie/$movieId/credits'; //Segment of Api needed to get the last movies
    final jsonData = await _getJsonData(segmet);
    final creditsResponse = Credits.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    const segment = '3/search/movie';
    final url = Uri.http(_BaseUrl, segment,
        {'api_key': _ApiKey, 'language': _Language, 'query': query});
    final response = await http.get(url);
    final searchResponse = Search.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionByquery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovie('$value');
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
