import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/firebase_functions.dart';
import 'package:movies_app/models/user_model.dart';

class MyProvider extends ChangeNotifier{
  UserModel? userModel;
  User? firebaseUser;

  MyProvider(){
    firebaseUser=FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      initUser();
    }
  }
  initUser()async{
    userModel=await FirebaseFunctions.readUserData(firebaseUser!.uid);
    notifyListeners();


  }


}