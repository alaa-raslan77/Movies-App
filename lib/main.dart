import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/provider/my_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
  create: (context)=> MyProvider() ,


      child: myApp()));
}
