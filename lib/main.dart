import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'bloc/observer.dart';
import 'firebase_options.dart';
import 'my_app.dart';

bool isConnected = false;
Future<bool> requestPermission() async {
  var status = await Permission.storage.request();
  return status.isGranted;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  final connectionChecker = InternetConnectionChecker();

  final subscription = connectionChecker.onStatusChange.listen(
    (InternetConnectionStatus status) {
      if (status == InternetConnectionStatus.connected) {
        print('Connected to the internet');
        isConnected = true;
      } else {
        print('Disconnected from the internet');
        isConnected = false;
      }
    },
  );
  await requestPermission();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  await Hive.initFlutter();
  Hive.registerAdapter(MovieModelAdapter());
  runApp(myApp());
}
