import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/models/MovieResponse.dart';
import 'colors_and_theme/app_colors.dart';
import 'details_screens/movie_details_screen.dart';

class MovieItem extends StatelessWidget {
  List<Results> results;
  int index;
  MovieItem({super.key, required this.results, required this.index});

  @override
  Widget build(BuildContext context) {
    return

      Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, MovieDetailsScreen.routeName,
              arguments: results[index]);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 150,
                height: 84,
                child: Stack(children: [
                  results[index].backdropPath == null
                      ? Image.asset(
                          "assets/images/no_image.png",
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          "https://image.tmdb.org/t/p/w500${results[index].backdropPath}",
                          fit: BoxFit.fill,
                        ),

                ]),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    results[index].title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    results[index].releaseDate!.substring(
                        0, results[index].releaseDate!.length.clamp(0, 4)),
                    style: GoogleFonts.inter(
                        color: Color(0xffB5B4B4),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.colorYellow,
                        size: 15,
                      ),
                      Text(
                        "${results[index].voteAverage!.toStringAsFixed(1)}",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    )
    ;
  }
}
