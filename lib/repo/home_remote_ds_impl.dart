import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/cache/cache_category.dart';
import 'package:movies_app/cache/cache_more_like_this.dart';
import 'package:movies_app/cache/cache_movie_details.dart';
import 'package:movies_app/cache/cache_new_releases.dart';
import 'package:movies_app/cache/cache_popular.dart';
import 'package:movies_app/cache/cache_recommended.dart';
import 'package:movies_app/cache/cache_watch_list.dart';
import 'package:movies_app/constans/constans.dart';
import 'package:movies_app/firebase_functions.dart';
import 'package:movies_app/models/MovieResponse.dart';
import 'package:movies_app/models/NewReleases.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repo/repo.dart';

class HomeRemoteDSImpl implements HomeRepo {
  @override
  Future<MovieDetails> getMovieDetails(String movie_id) async {
    //https://api.themoviedb.org/3/movie/{movie_id}
    Uri url = Uri.https(Constants.baseUrl, "/3/movie/$movie_id");
    http.Response response = await http
        .get(url, headers: {"Authorization": Constants.Authorization});
    var json = jsonDecode(response.body);
    MovieDetails movieDetails = MovieDetails.fromJson(json);
    await CacheMovieDetails.saveMovieDetails(movieDetails);

    return movieDetails;
  }

  @override
  Future<NewRealeases> getNewReleases() async {
    // https://api.themoviedb.org/3/movie/upcoming

    Uri url = Uri.https(Constants.baseUrl, "/3/movie/upcoming");
    http.Response response = await http
        .get(url, headers: {"Authorization": Constants.Authorization});

    var json = jsonDecode(response.body);
    NewRealeases newReleases = NewRealeases.fromJson(json);
    await CacheNewReleases.saveNewReleases(newReleases);
    return newReleases;
  }

  @override
  Future<MovieResponse> getPopular() async {
    // https://api.themoviedb.org/3/movie/popular
    Uri url = Uri.https(
      Constants.baseUrl,
      "/3/movie/popular",
    );
    http.Response response = await http
        .get(url, headers: {"Authorization": Constants.Authorization});
    var json = jsonDecode(response.body);

    MovieResponse popularResponse = MovieResponse.fromJson(json);
    await CachePopular.savePopular(popularResponse);
    return popularResponse;
  }

  @override
  Future<MovieResponse> getRecommended() async {
    // https://api.themoviedb.org/3/movie/top_rated

    Uri url = Uri.https(Constants.baseUrl, "/3/movie/top_rated");
    http.Response response = await http
        .get(url, headers: {"Authorization": Constants.Authorization});

    var json = jsonDecode(response.body);
    MovieResponse recommended = MovieResponse.fromJson(json);
    await CacheRecommended.saveRecommended(recommended);

    return recommended;
  }

  @override
  Future<MovieResponse> categoryMovies(String id) async {
    // https://api.themoviedb.org/3/discover/movie?with_genres=16
    Uri url = Uri.https(Constants.baseUrl, "/3/discover/movie", {
      "with_genres": id,
    });

    http.Response response = await http
        .get(url, headers: {"Authorization": Constants.Authorization});

    var json = jsonDecode(response.body);
    MovieResponse categoryResponse = MovieResponse.fromJson(json);
    await CacheCategory.saveCategory(categoryResponse);

    return categoryResponse;
  }

  @override
  Future<MovieResponse> getMoreLikeThis(String movie_id) async {
    //https://api.themoviedb.org/3/movie/{movie_id}/similar
    Uri url = Uri.https(Constants.baseUrl, "/3/movie/$movie_id/similar");
    http.Response response = await http
        .get(url, headers: {"Authorization": Constants.Authorization});
    var json = jsonDecode(response.body);
    MovieResponse moreLikeThis = MovieResponse.fromJson(json);
    await CacheMoreLikeThis.saveMoreLikeThis(moreLikeThis);

    return moreLikeThis;
  }

  @override
  Future<List<MovieModel>> getMoviesCubit() async {
    try {
      var movieDocs = await FirebaseFunctions.getMovies();

      List<MovieModel> movies =
          movieDocs.docs.map((doc) => doc.data()).toList();

      await CacheWatchList.saveWatchList(movies);

      return movies;
    } catch (e) {
      print('Error in getMoviesCubit: $e');
      return [];
    }
  }
}
