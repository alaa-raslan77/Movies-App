import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/firebase_functions.dart';
import 'package:movies_app/models/movie_model.dart';
import '../details_screens/movie_details_screen.dart';
import '../models/slider_model.dart';

class SliderCard extends StatefulWidget {
  MovieModel movieModel;

  SliderModel sliderModel;
  SliderCard(
      {super.key,
      required this.sliderModel,
        required this.movieModel
      });

  @override
  State<SliderCard> createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  bool isSelected=false;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items:
        widget.sliderModel.item_card.map((item) => Container(
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
                            width: widget.sliderModel.width,
                            height: widget.sliderModel.height,):
                            Image.network(item.posterPath==null?"assets/images/no_image.png":
                              "https://image.tmdb.org/t/p/w500${item.posterPath}",
                              fit: BoxFit.fill,
                              width: widget.sliderModel.width,
                              height: widget.sliderModel.height,
                            ),
                            isSelected==true?
                            GestureDetector(
                              onTap: (){
                                //FirebaseFunctions.deleteMovie(item.id.toString());
                                setState(() {
                                  isSelected=false;
                                });
                              },
                              child: Image.asset(
                                "assets/images/after_adding.png",
                                width: 27,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ):
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
                                setState(() {
                                  isSelected=true;
                                });
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
          height: widget.sliderModel.height,
          disableCenter: false,
          padEnds: false,
          viewportFraction: widget.sliderModel.fraction,
        ));
  }
}
