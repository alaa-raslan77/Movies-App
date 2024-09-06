import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/cubit_firebase.dart';
import 'package:movies_app/bloc/cubit_setstate.dart';
import 'package:movies_app/bloc/cubit_watch_list.dart';
import 'package:movies_app/bloc/states_firebase.dart';
import 'package:movies_app/firebase_functions.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repo/home_local_ds_impl.dart';
import 'package:movies_app/repo/home_remote_ds_impl.dart';
import '../details_screens/movie_details_screen.dart';
import '../models/slider_model.dart';

class SliderCard extends StatelessWidget {
  MovieModel movieModel;

  SliderModel sliderModel;
  SliderCard({super.key, required this.sliderModel, required this.movieModel});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context)=>FirebaseCubit(),
      ),
      BlocProvider(create: (context)=>SetStateCubit()),
      BlocProvider(create: (context)=>WatchListCubit(isConnected ? HomeRemoteDSImpl() : HomeLocalDSImpl()))
      ],

      child: BlocConsumer<FirebaseCubit,FirebaseState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return CarouselSlider(
              items: sliderModel.item_card
                  .map((item){
                bool isAdded = SetStateCubit.get(context).addedMovies[item.id] ?? false;

                return Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MovieDetailsScreen.routeName,
                          arguments: item);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Stack(children: [
                              item.posterPath == null
                                  ? Image.asset(
                                "assets/images/no_image.png",
                                fit: BoxFit.fill,
                                width: sliderModel.width,
                                height: sliderModel.height,
                              )
                                  : Image.network(
                                item.posterPath == null
                                    ? "assets/images/no_image.png"
                                    : "https://image.tmdb.org/t/p/w500${item.posterPath}",
                                fit: BoxFit.fill,
                                width: sliderModel.width,
                                height: sliderModel.height,
                              ),
                                 isAdded ? GestureDetector(
                                onTap: () {
                                  SetStateCubit.get(context).notAdded(item.id);

                                  FirebaseFunctions.deleteMovie(item.id.toString());

                                },
                                child: Image.asset(
                                  "assets/images/after_adding.png",
                                  width: 27,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ) : GestureDetector(
                                onTap: () {
                                  MovieModel movie = MovieModel(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      movieId: item.id.toString(),
                                      path: item.backdropPath ??
                                          "assets/images/no_image.png",
                                      releaseDate:
                                      item.releaseDate.toString(),
                                      title: item.title!,
                                      vote: item.voteAverage!
                                          .toStringAsFixed(1)
                                          .toString(),
                                      isInDatabase: true);
                                  FirebaseCubit.get(context)
                                      .addMovie(movie);

                                  SetStateCubit.get(context).isAdded(item.id);

                                },
                                child: Image.asset(
                                  "assets/images/before_adding.png",
                                  width: 27,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ));})
                  .toList(),
              options: CarouselOptions(
                autoPlay: false,
                height: sliderModel.height,
                disableCenter: false,
                padEnds: false,
                viewportFraction: sliderModel.fraction,
              ));

        },

      ),
    );
  }


}
