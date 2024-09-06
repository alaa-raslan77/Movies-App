import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/bloc/states_firebase.dart';
import 'package:movies_app/firebase_functions.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/models/user_model.dart';

class FirebaseCubit extends Cubit<FirebaseState> {
  FirebaseCubit() : super(FirebaseInitState());

  static FirebaseCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  User? firebaseUser;

  Future<void> addMovie(MovieModel movie) async {
    try {
      emit(AddMoviesLoadingState());
      var collection = FirebaseFunctions.moviesCollection();
      var docRef = collection.doc();
      movie.id = docRef.id;
      await docRef.set(movie); // Make sure to convert the model to Map
      emit(AddMoviesSuccessState());
    } catch (e) {
      emit(AddMoviesErrorState());
    }
  }


  Future<void> addUser(UserModel userModel) async {
    try {
      emit(AddUserLoadingState());
      await FirebaseFunctions.addUser(userModel);
    } catch (e) {
      emit(AddUserErrorState());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(SignInLoadingState());

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      firebaseUser = userCredential.user;
      UserModel userModel = UserModel(id: userCredential.user!.uid);
      await FirebaseFunctions.addUser(userModel);

      emit(SignInSuccessState());
    } catch (e) {
      emit(SignInErrorState());
    }
  }

  void initUser() async {
    try {
      emit(CurrentUserLoading());
      firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        userModel = await FirebaseFunctions.readUserData(firebaseUser!.uid);
        emit(CurrentUserSuccess(userModel!));
      }
    } catch (e) {
      emit(CurrentUserError());
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(NoCurrentUser());
  }
}
