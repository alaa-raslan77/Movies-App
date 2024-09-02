import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset("assets/images/alta.png")),
          SizedBox(width:10 ,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Alita Battle Angel",style: GoogleFonts.inter(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.w400
              ),),
              Text("2019",style: GoogleFonts.inter(
                color: Color(0xffB5B4B4),
                fontSize: 14,
                fontWeight: FontWeight.w400
              ),),
              Text("Rosa Salazar, Christoph Waltz",style: GoogleFonts.inter(
                color: Color(0xffB5B4B4),
                fontSize: 14,
                fontWeight: FontWeight.w400
               ),
              )
            ],
          )
        ],
      ),
    )
    ;
  }
}
