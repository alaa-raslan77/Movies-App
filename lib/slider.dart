import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/PopularResponse.dart';

import 'movie_details_screen.dart';

class SliderCard extends StatelessWidget {

  List<Results> item_card;
  double width;
  double height;
  double fraction;
  // Function onClick;
  SliderCard(
      {super.key,
      required this.item_card,
      required this.width,
      required this.height,
      required this.fraction});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: item_card
            .map((item) => Container(
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
                            (children: [
                            Image.network(
                              "https://image.tmdb.org/t/p/w500${item.posterPath}",
                              fit: BoxFit.fill,
                              width: width,
                              height: height,
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
                          ]),
                        ),
                      ),
                    ],
                  ),
                )))
            .toList(),
        options: CarouselOptions(

          autoPlay: false,
          height: height,
          disableCenter: false,
          padEnds: false,
          viewportFraction: fraction,
        ));
  }
}
