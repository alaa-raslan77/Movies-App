import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movies_app/models/MovieResponse.dart';
import 'package:movies_app/api_manger.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';

import '../details_screens/movie_details_screen.dart';
import '../firebase_functions.dart';
import '../models/movie_model.dart';
import '../models/slider_model.dart';

class SliderDetailsCard extends StatelessWidget {

  SliderModel sliderModel;
  SliderDetailsCard(
      {super.key,
        required this.sliderModel
      });

  @override
  Widget build(BuildContext context) {
    return  CarouselSlider(
        items: sliderModel.item_card.map((item) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),

              color: AppColors.cardColor,
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children:  [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MovieDetailsScreen.routeName,
                              arguments: item
                            );
                          },
                          child:item.posterPath == null
                              ? Image.asset("assets/images/no_image.png",  fit: BoxFit.cover,
                            width: sliderModel.width,
                            height: sliderModel.height,): Image.network(
                            "https://image.tmdb.org/t/p/w500${item.posterPath??''}",
                            fit: BoxFit.fill,
                            width: sliderModel.width,
                            height: sliderModel.height,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            MovieModel movie =MovieModel(
                                uid: FirebaseAuth.instance.currentUser!.uid,
                                movieId: item.id.toString(),
                                path: item.backdropPath??"assets/images/no_image.png",
                                releaseDate: item.releaseDate.toString(),
                                title: item.title!,
                                vote: item.voteAverage!.toStringAsFixed(1).toString(),
                                isInDatabase: true
                            );
                            FirebaseFunctions.addMovie(movie);
                          },
                          child: Image.asset(
                            "assets/images/before_adding.png",
                            width: 27,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),

                      ] ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0,left: 8,bottom: 0,right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                              Icon(Icons.star,color: AppColors.colorYellow,size: 15,),
                            Text(
                              "${item.voteAverage!.toStringAsFixed(1)}",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${item.title??''}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              item.releaseDate!.substring(0, item.releaseDate!.length.clamp(0, 4)),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),FutureBuilder(future: ApiManger.getMovieDetails(item.id.toString()),
                                builder:
                            (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return LoadingAnimationWidget.waveDots(color: Colors.white,
                                    size: 20);
                              }
                              if (snapshot.hasError) {
                                return Text(
                                  "something went wrong",
                                  style: TextStyle(color: Colors.white),
                                );
                              }
                              var details = snapshot.data!;
                              return   Text(
                                "  RT  ${details.runtime! ~/ 60}h ${((details.runtime! / 60 - details.runtime! ~/ 60) * 60).toStringAsFixed(0)}m",

                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              );
                             },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
          autoPlay: false,
          height: 215,
          disableCenter: false,
          padEnds: false,
          viewportFraction: sliderModel.fraction,


        ));
  }
}
