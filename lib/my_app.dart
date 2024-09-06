import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/cubit_firebase.dart';
import 'package:movies_app/colors_and_theme/my_theme_data.dart';
import 'package:movies_app/register/sign_in.dart';
import 'details_screens/category_details_screen.dart';
import 'details_screens/movie_details_screen.dart';
import 'splash_screen.dart';
import 'home_screen.dart';

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirebaseCubit(),
      child: MaterialApp(
        darkTheme: MyThemeData.DarkTheme,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SignIn.routeName: (context) => SignIn(),
          HomeScreen.routeName: (context) => HomeScreen(),
          SplashScreen.routeName: (context) => SplashScreen(),
          MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
          CategoryDetailsScreen.routeName: (context) => CategoryDetailsScreen(),
        },
      ),
    );
  }
}
