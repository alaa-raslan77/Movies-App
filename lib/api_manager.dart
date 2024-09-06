import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/constans/constans.dart';
import 'package:movies_app/models/MovieResponse.dart';

class ApiManager {
  static Future<MovieResponse> searchMovies(String query) async {
    // https://api.themoviedb.org/3/search/movie
    Uri url = Uri.https(Constants.baseUrl, "/3/search/movie", {
      "query": query,
    });

    http.Response response = await http.get(url, headers: {
      "Authorization":Constants.Authorization
    });

    var json = jsonDecode(response.body);

    MovieResponse searchResponse = MovieResponse.fromJson(json);
    return searchResponse;
  }
}
