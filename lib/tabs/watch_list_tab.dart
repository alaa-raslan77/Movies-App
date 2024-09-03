import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WatchListTab extends StatelessWidget {
  const WatchListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
      child: Column(children: [
        Text("Watchlist",
          style: GoogleFonts.inter(
              fontSize: 27,
              color: Colors.white,
              fontWeight: FontWeight.w400

          ),),

      ],),
    );
  }
}
