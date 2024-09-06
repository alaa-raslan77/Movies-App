import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/state_watch_list.dart';
import 'package:movies_app/firebase_functions.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repo/repo.dart';

class WatchListCubit extends Cubit<WatchListState> {
  HomeRepo repo;
  WatchListCubit(this.repo) : super(WatchListInitState());
  static WatchListCubit get(context) => BlocProvider.of(context);
  List<MovieModel> movies = [];

  Future<void> getMovies() async {
    try {
      emit(GetMoviesLoadingState());
      movies = await repo.getMoviesCubit();
      if (movies.isEmpty) {
        emit(GetNoMovies());
      } else {
        emit(GetMoviesSuccessState());
      }
    } catch (e) {
      print(e.toString());

      emit(GetMoviesErrorState());
    }
  }
}
