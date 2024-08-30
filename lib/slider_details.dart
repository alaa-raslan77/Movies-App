import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';

import 'movie_details_screen.dart';

class SliderDetailsCard extends StatelessWidget {
  List<String> item_card;
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
            margin: EdgeInsets.symmetric(horizontal: 5.0),
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
                            );
                          },
                          child: Image.asset(
                            item,
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
                    padding: const EdgeInsets.only(left: 8,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                              Icon(Icons.star,color: AppColors.colorYellow,size: 15,),
                            Text(
                              "7.7",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Deadpool 2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "2018 R 1h 59m",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 8,
                          ),
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
