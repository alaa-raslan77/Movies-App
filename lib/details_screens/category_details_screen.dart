import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movies_app/api_manger.dart';
import 'package:movies_app/models/category_model.dart';

import '../colors_and_theme/app_colors.dart';
import 'movie_details_screen.dart';

class CategoryDetailsScreen extends StatelessWidget {
  static const String routeName = "categoryScreen";
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as CategoryModel;

    return Scaffold(
        appBar: AppBar(
          title: Text("${model.label} Category",
              style: GoogleFonts.inter(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w400)),
          iconTheme: IconThemeData(size: 30),
        ),
        body: FutureBuilder(
          future: ApiManger.categoryMovies(model.id),
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
            var category = snapshot.data?.results ?? [];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Color(0xff707070),
                        indent: 20,
                        endIndent: 20,
                      ),
                  itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, MovieDetailsScreen.routeName,
                                arguments: category[index]);
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 150,
                                  height: 100,
                                  child: Stack(children: [
                                    category[index].backdropPath == null
                                        ? Image.asset(
                                            "assets/images/no_image.png",
                                            fit: BoxFit.fill,
                                          )
                                        : Image.network(
                                            "https://image.tmdb.org/t/p/w500${category[index].backdropPath}",
                                            fit: BoxFit.fill,
                                          ),
                                    Image.asset(
                                        "assets/images/before_adding.png"),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      category[index].title ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      category[index].releaseDate!.substring(
                                          0,
                                          category[index]
                                              .releaseDate!
                                              .length
                                              .clamp(0, 4)),
                                      style: GoogleFonts.inter(
                                          color: Color(0xffB5B4B4),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppColors.colorYellow,
                                          size: 15,
                                        ),
                                        Text(
                                          "${category[index].voteAverage!.toStringAsFixed(1)}",
                                          style: TextStyle(
                                            color: Colors.yellow,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  itemCount: category.length),
            );
          },
        ));
  }
}
