import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';
import 'package:movies_app/home_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName ="splashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AudioPlayer player = AudioPlayer();
    Source path = AssetSource("audio/splash_audio.mp3");
    player.play(path);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(

          children: [
            Image.asset("assets/images/splash_logo.png")
          ],
        ),
        backgroundColor: AppColors.colorBlack,
        nextScreen: const HomeScreen() ,
        splashIconSize: 250,
      duration: 2000,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
      animationDuration: Duration(seconds: 1),

    );
  }
}
