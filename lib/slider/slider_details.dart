import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movies_app/bloc/cubit_firebase.dart';
import 'package:movies_app/bloc/cubit_setstate.dart';
import 'package:movies_app/bloc/cubit_watch_list.dart';
import 'package:movies_app/bloc/states_firebase.dart';
import 'package:movies_app/colors_and_theme/app_colors.dart';
import 'package:movies_app/repo/home_local_ds_impl.dart';
import 'package:movies_app/repo/home_remote_ds_impl.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../details_screens/movie_details_screen.dart';
import '../firebase_functions.dart';
import '../main.dart';
import '../models/movie_model.dart';
import '../models/slider_model.dart';

class SliderDetailsCard extends StatelessWidget {
  SliderModel sliderModel;
  SliderDetailsCard({super.key, required this.sliderModel});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>FirebaseCubit(),),
        BlocProvider(create: (context)=>SetStateCubit()),
        BlocProvider(create: (context)=>WatchListCubit(isConnected ? HomeRemoteDSImpl() : HomeLocalDSImpl()))
      ],

        child: BlocConsumer<FirebaseCubit,FirebaseState>(
        listener: (context, state) {

    },
    builder: (context, state) {
     return CarouselSlider(
          items: sliderModel.item_card.map((item) {
            bool isAdded = SetStateCubit.get(context).addedMovies[item.id] ?? false;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                color: AppColors.cardColor,
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, MovieDetailsScreen.routeName,
                                arguments: item);
                          },
                          child: item.posterPath == null
                              ? Image.asset(
                                  "assets/images/no_image.png",
                                  fit: BoxFit.cover,
                                  width: sliderModel.width,
                                  height: sliderModel.height,
                                )
                              : Image.network(
                                  "https://image.tmdb.org/t/p/w500${item.posterPath ?? ''}",
                                  fit: BoxFit.fill,
                                  width: sliderModel.width,
                                  height: sliderModel.height,
                                ),
                        ),isAdded ? GestureDetector(
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
                        ) :
                        GestureDetector(
                          onTap: () {
                            MovieModel movie = MovieModel(
                                uid: FirebaseAuth.instance.currentUser!.uid,
                                movieId: item.id.toString(),
                                path: item.backdropPath ??
                                    "assets/images/no_image.png",
                                releaseDate: item.releaseDate.toString(),
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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, left: 8, bottom: 14, right: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.colorYellow,
                                size: 15,
                              ),
                              Text(
                                "${item.voteAverage!.toStringAsFixed(1)}",
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "${item.title ?? ''}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                item.releaseDate!.substring(
                                    0, item.releaseDate!.length.clamp(0, 4)),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),

                              ),
                              BlocProvider(
                                  create: (context) => HomeCubit(isConnected?HomeRemoteDSImpl():HomeLocalDSImpl())
                                    ..getMovieDetails(item.id.toString()),
                                  child: BlocConsumer<HomeCubit, HomeState>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        if (state
                                            is HomeGetMovieDetailsLoadingState) {
                                          return LoadingAnimationWidget.waveDots(
                                              color: AppColors.colorGray,
                                              size: 20);
                                        }
                                        var movieDetails =
                                            HomeCubit.get(context).movieDetails;

                                        return Text(
                                          " RT ${movieDetails?.runtime != null ? '${movieDetails!.runtime! ~/ 60}h ${((movieDetails.runtime! / 60 - movieDetails.runtime! ~/ 60) * 60).toStringAsFixed(0)}m' : ''}",
                                          style: GoogleFonts.inter(
                                              color: Color(0xffB5B4B4),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        );
                                      }))
                            ],
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
            viewportFraction: sliderModel.fraction,
          ));

    },

        ),
    );
  }
}
