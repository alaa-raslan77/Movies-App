import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../movie_search_delegate.dart';

class SearchTab extends StatelessWidget {
  SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Column(
        children: [
          TextFormField(
            onTap: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: GoogleFonts.inter(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                    color: Colors.white,
                    width: 1), // Border color when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                    color: Colors.white, width: 1), // Border color when focused
              ),
              filled: true,
              fillColor: Color(0xff514F4F),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            ),
            style: TextStyle(color: Colors.white, fontSize: 17),
            cursorColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 375),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/search_pic.png",
                ),
                Text(
                  "No movies found",
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
