import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            return CircularProgressIndicator();
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
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, MovieDetailsScreen.routeName,
                          arguments: search[index]);
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 150,
                            height: 100,
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500${search[index].backdropPath}",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(width:10 ,),
                        Container(
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(search[index].title??'',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400
                                ),),
                              Text(search[index].releaseDate!.substring(0, search[index].releaseDate!.length.clamp(0, 4)),
                                style: GoogleFonts.inter(
                                    color: Color(0xffB5B4B4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),),
                              Row(
                                children: [
                                  Icon(Icons.star,color: AppColors.colorYellow,size: 15,),
                                  Text(
                                    "${search[index].voteAverage!.toStringAsFixed(1)}",
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
                itemCount: search.length),
          );
        });
  }


}