import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/firebase_functions.dart';
import 'package:movies_app/models/MovieResponse.dart';
import 'package:movies_app/models/movie_model.dart';

import '../details_screens/movie_details_screen.dart';
import '../models/slider_model.dart';

class SliderCard extends StatelessWidget {
  MovieModel movieModel;

  SliderModel sliderModel;
  SliderCard(
      {super.key,
      required this.sliderModel,
        required this.movieModel
      });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items:
        sliderModel.item_card.map((item) => Container(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailsScreen.routeName,
                      arguments: item
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Stack
                            (children: [item.posterPath == null
                          ? Image.asset("assets/images/no_image.png", fit: BoxFit.fill,
                            width: sliderModel.width,
                            height: sliderModel.height,):
                            Image.network(item.posterPath==null?"assets/images/no_image.png":
                              "https://image.tmdb.org/t/p/w500${item.posterPath}",
                              fit: BoxFit.fill,
                              width: sliderModel.width,
                              height: sliderModel.height,
                            ),
                            movieModel.isInDatabase?
                            Image.asset(
                              "assets/images/after_adding.png",
                              width: 27,
                              height: 40,
                              fit: BoxFit.cover,
                            ):
                            GestureDetector(
                              onTap: (){
                                MovieModel movie =MovieModel(
                                  movieId: item.id.toString(),
                                  path: item.backdropPath??"assets/images/no_image.png",
                                  releaseDate: item.releaseDate.toString(),
                                  title: item.title!,
                                  vote: item.voteAverage.toString(),
                                  isInDatabase: true
                                );
                                FirebaseFunctions.addMovie(movie);
                              },
                              child:

                              Image.asset(
                                "assets/images/before_adding.png",
                                width: 27,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),

                          ]),
                        ),
                      ),
                    ],
                  ),
                )))
            .toList(),
        options: CarouselOptions(

          autoPlay: false,
          height: sliderModel.height,
          disableCenter: false,
          padEnds: false,
          viewportFraction: sliderModel.fraction,
        ));
  }
}
