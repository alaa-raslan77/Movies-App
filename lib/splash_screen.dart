import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/cubit_firebase.dart';
import 'package:movies_app/bloc/states_firebase.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';
import 'package:movies_app/home_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:movies_app/register/sign_in.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    Source path = AssetSource("audio/splash_audio.mp3");
    player.play(path);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirebaseCubit()..initUser(),
      child: BlocConsumer<FirebaseCubit, FirebaseState>(
        listener: (context, state) {},
        builder: (context, state) {
          return AnimatedSplashScreen(
            splash: Column(
              children: [Image.asset("assets/images/splash_logo.png")],
            ),
            backgroundColor: AppColors.colorBlack,
            nextScreen: state is CurrentUserSuccess ? HomeScreen() : SignIn(),
            splashIconSize: 250,
            duration: 2100,
            curve: Curves.bounceOut,
            splashTransition: SplashTransition.sizeTransition,
            pageTransitionType: PageTransitionType.bottomToTop,
            animationDuration: Duration(seconds: 1),
          );
        },
      ),
    );
  }
}
