import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movies_app/movie_item.dart';
import 'api_manger.dart';
import 'colors_and_theme/app_colors.dart';
import 'details_screens/movie_details_screen.dart';

class MovieSearchDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
   return[
     IconButton(onPressed: (){
       query='';
       showSuggestions(context);
     }, icon: Icon(Icons.clear,color: Colors.white,size: 30,)),

     IconButton(onPressed: (){
       showResults(context);
     }, icon: Icon(Icons.search,color: Colors.white,size: 30,))
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,));
  }

  @override
  Widget buildResults(BuildContext context) {
    return BuildSearchWidget();

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset("assets/images/search_pic.png",),
            Text("No movies found",
              style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w400
              ),)
          ],),
      );
    }
    return BuildSearchWidget();

  }

  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(

      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff514F4F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Colors.white)

        ),

      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,

      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.inter(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.w400
        ),

      ),
      textTheme: TextTheme(

        titleLarge:  TextStyle(color: Colors.white,
            fontSize: 23
        ),

      ),
    );
  }
  Widget BuildSearchWidget(){
    return FutureBuilder(
        future: ApiManger.searchMovies(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.colorYellow, size: 50,
            ));
          }
          if (snapshot.hasError) {
            return Text(
              "something went wrong",
              style: TextStyle(color: Colors.white),
            );
          }
          var search = snapshot.data?.results??[];
          return   Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(color: Color(0xff707070),
                      indent: 20,
                      endIndent: 20,
                    ),
                itemBuilder: (context, index) => MovieItem(results: search, index: index),
                itemCount: search.length),
          );
        });
  }


}