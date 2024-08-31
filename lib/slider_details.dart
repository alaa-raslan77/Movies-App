import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/PopularResponse.dart';
import 'package:movies_app/api_manger.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';

import 'movie_details_screen.dart';

class SliderDetailsCard extends StatelessWidget {

  List<Results> item_card;
  double width;
  double height;
  double fraction;
  // Function onClick;
  SliderDetailsCard(
      {super.key,
        required this.item_card,
        required this.width,
        required this.height,
        required this.fraction});

  @override
  Widget build(BuildContext context) {
    return  CarouselSlider(
        items: item_card.map((item) {
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
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500${item.posterPath}",
                            fit: BoxFit.fill,
                            width: width,
                            height: height,
                          ),
                        ),
                        Image.asset(
                          "assets/images/before_adding.png",
                          width: 27,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, left: 2),
                          child: Icon(
                            Icons.add,
                            size: 22,
                          ),
                        )
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
                                return CircularProgressIndicator();
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

                            },)
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
          viewportFraction: fraction,


        ));
  }
}
