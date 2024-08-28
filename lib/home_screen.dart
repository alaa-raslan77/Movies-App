import 'package:flutter/material.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName ="home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: AppColors.bottomBar,
        title: Text("Movies app",style: TextStyle(color: Colors.white),),
      ),

    );
  }
}
