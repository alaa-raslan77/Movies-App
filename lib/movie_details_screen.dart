import 'package:flutter/material.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';
import 'package:movies_app/slider.dart';
import 'package:movies_app/slider_details.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "movieDetailsScreen";
  List<String> newReleases = [
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
  ];
  MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: Text(
          "Dora and the lost city of gold",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: 230,
                    child: Image.asset(
                      "assets/images/Image.png",
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
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Dora and the lost city of gold",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            Text(
              "Dora and the lost city of gold",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Stack(children: [
                      Image.asset(
                        "assets/images/Image.png",
                        width: 200,
                        height: 210,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Image.asset(
                          "assets/images/before_adding.png",
                          width: 27,
                          height: 36,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, left: 38),
                        child: Icon(
                          Icons.add,
                          size: 22,
                        ),
                      )
                    ]),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 65,
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                              border: Border(
                                  left: BorderSide(color: Colors.white),
                                  top: BorderSide(color: Colors.white),
                                  bottom: BorderSide(color: Colors.white),
                                  right: BorderSide(color: Colors.white))),
                          child: Center(
                              child: Text(
                            "Action",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        Container(
                          height: 25,
                          width: 65,
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                              border: Border(
                                  left: BorderSide(color: Colors.white),
                                  top: BorderSide(color: Colors.white),
                                  bottom: BorderSide(color: Colors.white),
                                  right: BorderSide(color: Colors.white))),
                          child: Center(
                              child: Text(
                            "Action",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        Container(
                          height: 25,
                          width: 65,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                              border: Border(
                                  left: BorderSide(color: Colors.white),
                                  top: BorderSide(color: Colors.white),
                                  bottom: BorderSide(color: Colors.white),
                                  right: BorderSide(color: Colors.white))),
                          child: Center(
                              child: Text(
                            "Action",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ],
                    ),
                    Text(
                      """Dora and the lost city of gold """,
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.colorYellow,
                        ),
                        Text(
                          "7.7",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),

                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 45),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              width: double.infinity,
              height: 280,
              color: AppColors.colorMidBlack,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "More Like This",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  SliderDetailsCard(
                    item_card: newReleases,
                    width: 110,
                    height: 150,
                    fraction: .3,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
