import 'package:flutter/material.dart';
import 'package:movies_app/MovieDetails.dart';

class MovieTypes extends StatelessWidget {
  MovieDetails movieDetails;
   MovieTypes({required this.movieDetails,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Container(
          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
          margin: EdgeInsets.only(right: 10,),
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
                "${movieDetails.genres![0].name}",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),

          margin: EdgeInsets.only(right: 10),
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
                "${movieDetails.genres![1].name}",
                style: TextStyle(color: Colors.white),
              )),
        ),
      Row(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),

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
                "${movieDetails.genres![2].name}",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),

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
                "${movieDetails.genres![3].name}",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),

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
                "${movieDetails.genres![3].name}",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],)
      ],
    );
  }
}
