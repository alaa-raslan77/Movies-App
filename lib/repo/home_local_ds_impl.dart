import 'package:movies_app/cache/cache_category.dart';
import 'package:movies_app/cache/cache_more_like_this.dart';
import 'package:movies_app/cache/cache_movie_details.dart';
import 'package:movies_app/cache/cache_new_releases.dart';
import 'package:movies_app/cache/cache_popular.dart';
import 'package:movies_app/cache/cache_recommended.dart';
import 'package:movies_app/cache/cache_watch_list.dart';
import 'package:movies_app/models/MovieResponse.dart';
import 'package:movies_app/models/NewReleases.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repo/repo.dart';

class HomeLocalDSImpl implements HomeRepo {
  @override
  Future<MovieDetails> getMovieDetails(String movie_id) async {
    MovieDetails response = await CacheMovieDetails.getMovieDetails();
    return response;
  }

  @override
  Future<NewRealeases> getNewReleases() async {
    NewRealeases response = await CacheNewReleases.getNewReleases();
    return response;
  }

  @override
  Future<MovieResponse> getPopular() async {
    MovieResponse response = await CachePopular.getPopular();
    return response;
  }

  @override
  Future<MovieResponse> getRecommended() async {
    MovieResponse response = await CacheRecommended.getRecommended();
    return response;
  }

  @override
  Future<MovieResponse> categoryMovies(String id) async {
    MovieResponse response = await CacheCategory.getCategory();
    return response;
  }

  @override
  Future<MovieResponse> getMoreLikeThis(String movie_id) async {
    MovieResponse response = await CacheMoreLikeThis.getMoreLikeThis();
    return response;
  }

  @override
  Future<List<MovieModel>> getMoviesCubit() async {
    try {
      List<MovieModel> movieModels = await CacheWatchList.getWatchList();
      print(movieModels);

      if (movieModels.isNotEmpty) {
        return movieModels;
      } else {
        throw Exception('No movies found in cache');
      }
    } catch (e) {
      print('Error fetching movies from Hive: $e');
      return [];
    }
  }
}
