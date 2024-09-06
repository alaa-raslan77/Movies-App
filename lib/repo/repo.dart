import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/models/MovieResponse.dart';
import 'package:movies_app/models/NewReleases.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/models/movie_model.dart';

abstract class HomeRepo{
  Future<MovieResponse> getPopular();
  Future<NewRealeases>getNewReleases();
  Future<MovieResponse>getRecommended();
  Future<MovieDetails>getMovieDetails(String movie_id);
  Future<MovieResponse> getMoreLikeThis(String movie_id);
  Future<MovieResponse> categoryMovies(String id);
  Future<List<MovieModel>>getMoviesCubit();

}