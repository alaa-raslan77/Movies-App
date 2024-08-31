import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/api_manger.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';
import 'package:movies_app/movie_types.dart';
import 'package:movies_app/slider.dart';
import 'package:movies_app/slider_details.dart';
import 'PopularResponse.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "movieDetailsScreen";

  MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as Results;
    // var modelCover = ModalRoute.of(context)?.settings.arguments as Results;
    // var modelWithDetails =
    //     ModalRoute.of(context)?.settings.arguments as Results;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: Text(
          "${model.title}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: ApiManger.getMovieDetails(model.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text(
              "something went wrong",
              style: TextStyle(color: Colors.white),
            );
          }
          var details = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: 230,
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500${details.backdropPath}",
                        fit: BoxFit.cover,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 85, left: 190),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.play_circle_fill_rounded,
                          size: 80,
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Text(
                  "${details.title}",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      details.releaseDate!.substring(0, 4) ?? '',
                      style: GoogleFonts.inter(
                          color: Color(0xffB5B4B4),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                      "  RT  ${details.runtime! ~/ 60}h ${((details.runtime! / 60 - details.runtime! ~/ 60) * 60).toStringAsFixed(0)}m",
                      style: GoogleFonts.inter(
                          color: Color(0xffB5B4B4),
                          fontSize: 14,
                          fontWeight: FontWeight.w400))
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Stack(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500${details.posterPath}",
                            width: 200,
                            height: 210,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 31, top: 20),
                          child: Image.asset(
                            "assets/images/before_adding.png",
                            width: 27,
                            height: 36,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 23, left: 33),
                          child: Icon(
                            Icons.add,
                            size: 22,
                          ),
                        )
                      ]),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: details.genres!.map((genre) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Center(
                                  child: Text(
                                    genre.name??'',
                                    style: GoogleFonts.inter(color: Colors.white,
                                    fontWeight: FontWeight.w400,fontSize: 14),
                                  ),
                                ),
                              );
                              }).toList(),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          details.overview!,
                          maxLines: 4,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.inter(
                              color: AppColors.smalltext,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height:20,),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.colorYellow,
                            ),
                            Text(
                              "${(details.voteAverage)!.toStringAsFixed(1)}",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              FutureBuilder(

                future: ApiManger.getMoreLikeThis(model.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text(
                      "something went wrong",
                      style: TextStyle(color: Colors.white),
                    );
                  }
                  var moreLikeThis = snapshot.data!.results??[];
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    width: double.infinity,
                    height: 290,
                    color: AppColors.colorMidBlack,
                    child: SingleChildScrollView(
                      child: Column(
                        
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "More Like This",
                            style: GoogleFonts.inter(color: Colors.white,
                                fontSize: 20,fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SliderDetailsCard(
                      
                            item_card: moreLikeThis,
                            width: 110,
                            height: 130,
                            fraction: .3,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
