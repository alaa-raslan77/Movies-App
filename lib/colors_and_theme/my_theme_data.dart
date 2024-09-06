import 'package:flutter/material.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';

class MyThemeData {
  static ThemeData DarkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.colorBlack,
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
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
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.colorBlack,
        onPrimary: AppColors.colorBlack,
        secondary: AppColors.colorBlack,
        onSecondary: AppColors.colorBlack,
        error: AppColors.colorBlack,
        onError: AppColors.colorBlack,
        background: AppColors.colorBlack,
        onBackground: AppColors.colorBlack,
        surface: AppColors.colorBlack,
        onSurface: AppColors.colorBlack),
  );
}
