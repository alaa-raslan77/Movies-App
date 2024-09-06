import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<MovieModel> moviesCollection() {
    return FirebaseFirestore.instance
        .collection("WatchList")
        .withConverter<MovieModel>(
      fromFirestore: (snapshot, _) {
        return MovieModel.fromJson(snapshot.data()!);
      },
      toFirestore: (movie, _) {
        return movie.toJson();
      },
    );
  }

  static CollectionReference<UserModel> usersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  static Future<QuerySnapshot<MovieModel>> getMovies() {
    var collection = moviesCollection();
    return collection
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  static Future<void> deleteMovie(String id) {
    return moviesCollection().doc(id).delete();
  }

  static Future<UserModel?> readUserData(String uid) async {
    var collection = usersCollection();
    DocumentSnapshot<UserModel> docUser = await collection.doc(uid).get();
    return docUser.data();
  }

  static addUser(UserModel userModel) {
    var collection = usersCollection();
    var docRef = collection.doc(userModel.id);
    docRef.set(userModel);
  }
}
