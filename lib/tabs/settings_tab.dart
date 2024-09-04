import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';
import 'package:movies_app/regesters/log_in.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 47),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Settings",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 26,),
          Container(
            color: AppColors.colorMidBlack,
            padding: EdgeInsets.symmetric(vertical: 7,
            horizontal: 7),
            child: GestureDetector(
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(context, LogIn.routeName, (route) => false,);
              },

              child: Row(
                children: [
                  Icon(Icons.logout,size: 30,),
                  Text("  Log Out",style:
                    GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.normal
                    ),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
