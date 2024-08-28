
import 'package:flutter/material.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';

class MyThemeData {


  static ThemeData DarkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.colorBlack,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: Colors.white

        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.colorYellow,
      unselectedItemColor: Colors.white,
      backgroundColor: AppColors.bottomBar,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,

    ),
    dividerTheme: DividerThemeData(
      color: Colors.white,
      thickness: 1,

    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),


  );
}

