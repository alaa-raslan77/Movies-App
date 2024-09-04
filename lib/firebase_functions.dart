import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/models/movie_model.dart';

class FirebaseFunctions {

  static CollectionReference<MovieModel> moviesCollection(){
    return FirebaseFirestore.instance.collection("WatchList")
        .withConverter<MovieModel>(
      fromFirestore: (snapshot, _) {
        return  MovieModel.fromJson(snapshot.data()!);

      },
      toFirestore: (movie, _) {
        return movie.toJson();
      },);
  }
 static Future<void> addMovie(MovieModel movie) {
    var collection = moviesCollection();
    var docRef=collection.doc();
    movie.id=docRef.id;
    return docRef.set(movie);

  }



  static Future<QuerySnapshot<MovieModel>> getMovies(){
    var collectin = moviesCollection();
    return collectin.get();

  }
  static Future<void>deleteMovie(String id){
   return moviesCollection().doc(id).delete();

  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


}
