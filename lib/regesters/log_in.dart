import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';
import 'package:movies_app/firebase_functions.dart';
import 'package:movies_app/home_screen.dart';

class LogIn extends StatefulWidget {
  static const String routeName ="logIn";
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //SizedBox(height: 200,),
          Center(
            child: Image.asset("assets/images/splash_logo.png",height: 200,
            width: 150,),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
            elevation: 40,
            shadowColor: AppColors.colorGray,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            color: AppColors.colorMidBlack,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 33),
              child: Column(
                children: [
                  Text("Sign In",
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.white
                  ),),
                  SizedBox(height: 18,),
                  ElevatedButton(onPressed: (){
                    FirebaseFunctions.signInWithGoogle().then((onValue){
                      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                    });
                    
                  },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //SizedBox(width: 20,),
                          Image.asset("assets/images/google.png",width: 70,height: 70,),
                  Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                  TextSpan(text: "Sign in with ",style:
                  GoogleFonts.inter(color: Colors.white,fontSize: 25)),
                  TextSpan( text: "G",style: TextStyle(fontSize: 25,color: Colors.blueAccent,)),
                  TextSpan( text: "o",style: TextStyle(fontSize: 25,color: Colors.red,)),
                  TextSpan( text: "o",style: TextStyle(fontSize: 25,color: Colors.yellow.shade600,)),
                  TextSpan( text: "g",style: TextStyle(fontSize: 25,color: Colors.blueAccent,)),
                  TextSpan( text: "l",style: TextStyle(fontSize: 25,color: Colors.green,)),
                  TextSpan( text: "e",style: TextStyle(fontSize: 25,color: Colors.red,)),

                  ])


                  )],
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
