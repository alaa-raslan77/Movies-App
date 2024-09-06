import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/states.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/repo/repo.dart';
import '../models/MovieResponse.dart';
import '../models/NewReleases.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepo repo;

  HomeCubit(this.repo) : super(HomeInitState());

  MovieResponse? popularResponse;
  NewRealeases? newReleases;
  MovieResponse? recommended;
  MovieDetails? movieDetails;
  MovieResponse? moreLikeThis;
  MovieResponse? searchResponse;
  MovieResponse? categoryResponse;

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> getPopular() async {
    try {
      emit(HomeGetPopularLoadingState());
      popularResponse = await repo.getPopular();
      emit(HomeGetPopularSuccessState());
      getNewReleases();
      getRecommended();
    } catch (e) {
      emit(HomeGetPopularErrorState());
    }
  }

  Future<void> getNewReleases() async {
    try {
      emit(HomeGetNewReleasesLoadingState());
      newReleases = await repo.getNewReleases();
      emit(HomeGetNewReleasesErrorState());
    } catch (e) {
      emit(HomeGetNewReleasesErrorState());
    }
  }

  Future<void> getRecommended() async {
    try {
      emit(HomeGetRecommendedLoadingState());
      recommended = await repo.getRecommended();
      emit(HomeGetRecommendedSuccessState());
    } catch (e) {
      emit(HomeGetRecommendedErrorState());
    }
  }

  Future<void> getMovieDetails(String movie_id) async {
    try {
      emit(HomeGetMovieDetailsLoadingState());
      movieDetails = await repo.getMovieDetails(movie_id);
      emit(HomeGetMovieDetailsSuccessState());
      getMoreLikeThis(movie_id);
    } catch (e) {
      emit(HomeGetMovieDetailsErrorState());
    }
  }

  Future<void> getMoreLikeThis(String movie_id) async {
    try {
      emit(HomeGetMoreLikeThisLoadingState());
      moreLikeThis = await repo.getMoreLikeThis(movie_id);
      emit(HomeGetMoreLikeThisSuccessState());
    } catch (e) {
      emit(HomeGetMoreLikeThisErrorState());
    }
  }

  Future<void> categoryMovies(String id) async {
    try {
      emit(HomeGetCategoryLoadingState());
      categoryResponse = await repo.categoryMovies(id);
      emit(HomeGetCategorySuccessState());
    } catch (e) {
      emit(HomeGetCategoryErrorState());
    }
  }
}
