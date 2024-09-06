import 'package:movies_app/models/user_model.dart';

abstract class FirebaseState {}

class FirebaseInitState extends FirebaseState {}

class AddMoviesSuccessState extends FirebaseState {}

class AddMoviesLoadingState extends FirebaseState {}

class AddMoviesErrorState extends FirebaseState {}

class ReadUserDataSuccessState extends FirebaseState {}

class ReadUserDataLoadingState extends FirebaseState {}

class ReadUserDataErrorState extends FirebaseState {}

class SignInSuccessState extends FirebaseState {
  final UserModel user;
  SignInSuccessState(this.user);
}

class SignInLoadingState extends FirebaseState {}

class SignInErrorState extends FirebaseState {}

class AddUserSuccessState extends FirebaseState {}

class AddUserLoadingState extends FirebaseState {}

class AddUserErrorState extends FirebaseState {}

class CurrentUserLoading extends FirebaseState {}

class CurrentUserError extends FirebaseState {}

class CurrentUserSuccess extends FirebaseState {
  final UserModel user;
  CurrentUserSuccess(this.user);
}
class NoCurrentUser extends FirebaseState {}
