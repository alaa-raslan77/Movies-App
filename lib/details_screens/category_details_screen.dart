import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movies_app/api_manger.dart';
import 'package:movies_app/models/category_model.dart';

import '../colors_and_theme/app_colors.dart';
import '../firebase_functions.dart';
import '../models/movie_model.dart';
import '../movie_item.dart';
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
                  itemBuilder: (context, index) => MovieItem(results:category,index: index,),
                  itemCount: category.length),
            );
          },
        ));
  }
}
