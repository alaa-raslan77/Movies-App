import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/state_setstate.dart';

class SetStateCubit extends Cubit<SetState> {
  int selectedIndex = 0;
  Map<num?, bool> addedMovies = {};

  SetStateCubit() : super(InitSetState());
  static SetStateCubit get(context) => BlocProvider.of(context);

  ChangeBottmBar(int value) {
    selectedIndex = value;
    emit(ChangeBottomBarIndex());
  }

  isAdded(num? id) {
    addedMovies[id] = true;
    emit(MovieSelected());
  }

  notAdded(num? id) {
    addedMovies[id] = false;
    emit(NotMovieSelected());
  }
}
