import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../colors_and_theme/app_colors.dart';
import '../movie_details_screen.dart';
import '../slider.dart';
import '../slider_details.dart';

class SearchTab extends StatelessWidget {
  List<String> newReleases = [
    'assets/images/toyStory.png',
    'assets/images/Image.png',
    'assets/images/toyStory.png',
    'assets/images/toyStory.png',
    'assets/images/toyStory.png',
    'assets/images/toyStory.png',
    'assets/images/toyStory.png',
    'assets/images/toyStory.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
    'assets/images/Image.png',
  ];
   SearchTab({super.key});


  @override
  Widget build(BuildContext context) {
     return
    // Stack(
    //   children: [
    //     Container(
    //         width: double.infinity,
    //         height: 230,
    //         child: CarouselSlider(
    //           items: newReleases.map((item) => Image.asset(item,fit: BoxFit.fitWidth,
    //             width: double.infinity,
    //             height: 300,
    //           )).toList(),
    //           options: CarouselOptions(
    //             autoPlay: true,
    //             height: 200,
    //             disableCenter: false,
    //             padEnds: true,
    //             viewportFraction: 1,
    //           ),
    //
    //
    //         )),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 85, left: 190),
    //       child: IconButton(
    //           onPressed: () {},
    //           icon: Icon(
    //             Icons.play_circle_fill_rounded,
    //             size: 80,
    //           )),
    //     ),
    //     ////////////////////////////////////////
    //     Padding(
    //       padding: const EdgeInsets.only(left: 27, top: 100),
    //       child: Stack(children: [
    //         GestureDetector(
    //           onTap: () {
    //             Navigator.pushNamed(
    //               context,
    //               MovieDetailsScreen.routeName,
    //             );
    //           },
    //           child: Image.asset(
    //             newReleases[1],
    //           ),
    //         ),
    //         Image.asset(
    //           "assets/images/before_adding.png",
    //           width: 27,
    //           height: 36,
    //           fit: BoxFit.cover,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(top: 3, left: 2),
    //           child: Icon(
    //             Icons.add,
    //             size: 22,
    //           ),
    //         )
    //       ]),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 260, left: 200),
    //       child: Text(
    //         "Dora and the lost city of gold",
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     ),
    //     Container(
    //       margin: EdgeInsets.only(top: 320),
    //       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    //       width: double.infinity,
    //       height: 250,
    //       color: AppColors.colorMidBlack,
    //       child: SingleChildScrollView(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               "New Releases ",
    //               style: TextStyle(color: Colors.white, fontSize: 22),
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             // SliderCard(
    //             //   item_card: newReleases,
    //             //   width: 110,
    //             //   height:150 ,
    //             //   fraction: .3,
    //             // )
    //           ],
    //         ),
    //       ),
    //     ),
    //     Container(
    //       margin: EdgeInsets.only(top: 600),
    //       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    //       width: double.infinity,
    //       height: 290,
    //       color: AppColors.colorMidBlack,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             "Recomended",
    //             style: TextStyle(color: Colors.white, fontSize: 22),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           SliderDetailsCard(
    //             item_card: newReleases,
    //             width: 110,
    //             height: 150,
    //             fraction: .3,
    //           )
    //         ],
    //       ),
    //     )
    //   ],
    // )

      Container(
          color: Colors.blue,
        )





    ;
  }
}
