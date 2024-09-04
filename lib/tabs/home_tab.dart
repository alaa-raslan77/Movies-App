import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movies_app/api_manger.dart';
import 'package:movies_app/models/MovieResponse.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/models/slider_model.dart';
import '../colors_and_theme/app_colors.dart';
import '../details_screens/movie_details_screen.dart';
import '../firebase_functions.dart';
import '../slider/slider.dart';
import '../slider/slider_details.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.getPopular(),
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
        var results = snapshot.data?.results ?? [];
        return SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: results.map(
                  (item) {
                    return Container(
                      child: Stack(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, MovieDetailsScreen.routeName,
                                arguments: item);
                          },
                          child: item.backdropPath == null
                              ? Image.asset(
                                  "assets/images/no_image.png",
                                  fit: BoxFit.fitWidth,
                                  width: double.infinity,
                                  height: 300,
                                )
                              : Image.network(
                                  "https://image.tmdb.org/t/p/w500${item.backdropPath}",
                                  fit: BoxFit.fitWidth,
                                  width: double.infinity,
                                  height: 300,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 170, top: 110),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.play_circle_fill_rounded,
                                size: 80,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 170, left: 30),
                          child: Stack(children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, MovieDetailsScreen.routeName,
                                    arguments: item);
                              },
                              child: item.backdropPath == null
                                  ? Image.asset(
                                      "assets/images/no_image.png",
                                      width: 129,
                                      height: 199,
                                    )
                                  : Image.network(
                                      "https://image.tmdb.org/t/p/w500${item.posterPath}",
                                      width: 129,
                                      height: 199,
                                    ),
                            ),
                            GestureDetector(
                              onTap: () {
                                MovieModel movie = MovieModel(
                                    movieId: item.id.toString(),
                                    path: item.backdropPath ??
                                        "assets/images/no_image.png",
                                    releaseDate: item.releaseDate.toString(),
                                    title: item.title!,
                                    vote: item.voteAverage.toString(),
                                    isInDatabase: true);
                                FirebaseFunctions.addMovie(movie);
                              },
                              child: Image.asset(
                                "assets/images/before_adding.png",
                                width: 27,
                                height: 36,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 305, left: 165),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, MovieDetailsScreen.routeName,
                                  arguments: item);
                            },
                            child: Text(
                              item.title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 340, left: 165),
                            child: FutureBuilder(
                                future: ApiManger.getMovieDetails(
                                    item.id.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return LoadingAnimationWidget.waveDots(
                                      color: AppColors.colorGray,
                                      size: 30,
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Text(
                                      "something went wrong",
                                      style: TextStyle(color: Colors.white),
                                    );
                                  }
                                  var details = snapshot.data!;
                                  return Row(
                                    children: [
                                      Text(
                                        item.releaseDate!.substring(0, 4) ?? '',
                                        style: GoogleFonts.inter(
                                            color: Color(0xffB5B4B4),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "  RT  ${details.runtime! ~/ 60}h ${((details.runtime! / 60 - details.runtime! ~/ 60) * 60).toStringAsFixed(0)}m",
                                        style: GoogleFonts.inter(
                                            color: Color(0xffB5B4B4),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  );
                                }))
                      ]),
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  height: 355,
                  disableCenter: false,
                  padEnds: true,
                  viewportFraction: 1,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(top: 0),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: double.infinity,
                height: 230,
                color: AppColors.colorMidBlack,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Releases ",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: ApiManger.getNewReleases(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.colorGray,
                            size: 50,
                          ));
                        }
                        if (snapshot.hasError) {
                          return Text(
                            "something went wrong",
                            style: TextStyle(color: Colors.white),
                          );
                        }
                        var newReleases = snapshot.data?.results ?? [];
                        return Container(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SliderCard(
                                  movieModel: MovieModel(
                                      title: newReleases[0].title??'',
                                      releaseDate: newReleases[0].releaseDate??'',
                                      path: newReleases[0].backdropPath??'',
                                      vote: newReleases[0].voteAverage.toString()??'',
                                      movieId: newReleases[0].id.toString()??'',
                                  isInDatabase: false),
                                  sliderModel: SliderModel(
                                    width: 110,
                                    height: 150,
                                    fraction: .3,
                                    item_card: newReleases,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: double.infinity,
                height: 290,
                color: AppColors.colorMidBlack,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Recommended",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      future: ApiManger.getRecommended(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.colorGray,
                            size: 50,
                          ));
                        }
                        if (snapshot.hasError) {
                          return Text(
                            "something went wrong",
                            style: TextStyle(color: Colors.white),
                          );
                        }
                        var recommended = snapshot.data?.results ?? [];
                        return Container(
                            child: SliderDetailsCard(
                          sliderModel: SliderModel(
                              width: 110,
                              height: 130,
                              fraction: .3,
                              item_card: recommended),
                        ));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
