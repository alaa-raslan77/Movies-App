import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movies_app/firebase_functions.dart';
import '../colors_and_theme/app_colors.dart';

class WatchListTab extends StatelessWidget {
  const WatchListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return


        FutureBuilder(
            future: FirebaseFunctions.getMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.colorYellow,
                      size: 50,
                    ));
              }
              if (snapshot.hasError) {
                return Text(
                  "something went wrong",
                  style: TextStyle(color: Colors.white),
                );
              }

              var movies = snapshot.data?.docs.map((doc)=>doc.data()).toList();
              if (movies!.isEmpty){
                return Center(
                  child: Text("No Movies",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400
                  ),),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 40,right:5,left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5,left: 10),
                      child: Text("Watchlist",
                        style: GoogleFonts.inter(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w400

                        ),),
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Color(0xff707070),
                            indent: 20,
                            endIndent: 20,
                          ),
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 150,
                                    height: 83,
                                    child: Stack(children: [
                                      movies[index].path == null
                                          ? Image.asset(
                                        "assets/images/no_image.png",
                                        fit: BoxFit.fill,
                                      )
                                          : Image.network(
                                        "https://image.tmdb.org/t/p/w500${movies[index].path}",
                                        fit: BoxFit.cover,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                         // FirebaseFunctions.deleteMovie();
                                        },
                                        child: Image.asset(
                                            "assets/images/after_adding.png"),
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
                                        movies[index].title ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        movies[index].releaseDate!.substring(
                                            0,
                                            movies[index]
                                                .releaseDate!
                                                .length
                                                .clamp(0, 4)),
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
                                            "${movies[index].vote!}",
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
                          itemCount: movies.length),
                    ),
                  ],
                ),
              );
            },)

    ;
  }
}
