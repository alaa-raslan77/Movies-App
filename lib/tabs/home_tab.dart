import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movies_app/bloc/cubit.dart';
import 'package:movies_app/bloc/cubit_firebase.dart';
import 'package:movies_app/bloc/states.dart';
import 'package:movies_app/bloc/states_firebase.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/models/slider_model.dart';
import 'package:movies_app/repo/home_local_ds_impl.dart';
import 'package:movies_app/repo/home_remote_ds_impl.dart';
import '../bloc/cubit_setstate.dart';
import '../colors_and_theme/app_colors.dart';
import '../details_screens/movie_details_screen.dart';
import '../firebase_functions.dart';
import '../slider/slider.dart';
import '../slider/slider_details.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HomeCubit(isConnected ? HomeRemoteDSImpl() : HomeLocalDSImpl())
                ..getPopular(),
        ),
        BlocProvider(
          create: (context) => FirebaseCubit(),
        ),
        BlocProvider(create: (context) => SetStateCubit()),
      ],
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          AddMoviesErrorState;
          AddMoviesSuccessState;
          AddMoviesLoadingState;
        },
        builder: (context, state) {
          if (state is HomeGetPopularLoadingState ||
              state is HomeGetRecommendedLoadingState ||
              state is HomeGetNewReleasesLoadingState ||
              state is HomeGetMoreLikeThisLoadingState) {
            return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.colorYellow, size: 50));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  items: HomeCubit.get(context).popularResponse?.results?.map(
                        (item) {
                          bool isAdded =
                              SetStateCubit.get(context).addedMovies[item.id] ??
                                  false;

                          return Container(
                            child: Stack(children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MovieDetailsScreen.routeName,
                                      arguments: item);
                                },
                                child: item.backdropPath == null
                                    ? Image.asset(
                                        "assets/images/no_image.png",
                                        fit: BoxFit.fitWidth,
                                        width: double.infinity,
                                        height: 300,
                                      )
                                    : Image.network(
                                        "https://image.tmdb.org/t/p/w500${item.backdropPath}",
                                        fit: BoxFit.fitWidth,
                                        width: double.infinity,
                                        height: 300,
                                      ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 170, top: 110),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.play_circle_fill_rounded,
                                      size: 80,
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 170, left: 30),
                                child: Stack(children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, MovieDetailsScreen.routeName,
                                          arguments: item);
                                    },
                                    child: item.backdropPath == null
                                        ? Image.asset(
                                            "assets/images/no_image.png",
                                            width: 129,
                                            height: 199,
                                          )
                                        : Image.network(
                                            "https://image.tmdb.org/t/p/w500${item.posterPath}",
                                            width: 129,
                                            height: 199,
                                          ),
                                  ),
                                  isAdded
                                      ? GestureDetector(
                                          onTap: () {
                                            SetStateCubit.get(context)
                                                .notAdded(item.id);

                                            FirebaseFunctions.deleteMovie(
                                                item.id.toString());
                                          },
                                          child: Image.asset(
                                            "assets/images/after_adding.png",
                                            width: 27,
                                            height: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : GestureDetector(
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
                                            SetStateCubit.get(context)
                                                .isAdded(item.id);
                                          },
                                          child: Image.asset(
                                            "assets/images/before_adding.png",
                                            width: 27,
                                            height: 36,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 305, left: 165),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, MovieDetailsScreen.routeName,
                                        arguments: item);
                                  },
                                  child: Text(
                                    item.title ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 340, left: 165),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${item.releaseDate!.substring(0, 4) ?? ''}",
                                        style: GoogleFonts.inter(
                                            color: Color(0xffB5B4B4),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      BlocProvider(
                                          create: (context) => HomeCubit(
                                              isConnected
                                                  ? HomeRemoteDSImpl()
                                                  : HomeLocalDSImpl())
                                            ..getMovieDetails(
                                                item.id.toString()),
                                          child: BlocConsumer<HomeCubit,
                                                  HomeState>(
                                              listener: (context, state) {},
                                              builder: (context, state) {
                                                if (state
                                                    is HomeGetMovieDetailsLoadingState) {
                                                  return LoadingAnimationWidget
                                                      .waveDots(
                                                          color: AppColors
                                                              .colorGray,
                                                          size: 25);
                                                }
                                                var movieDetails =
                                                    HomeCubit.get(context)
                                                        .movieDetails;

                                                return Text(
                                                  "  RT  ${movieDetails?.runtime != null ? '${movieDetails!.runtime! ~/ 60}h ${((movieDetails.runtime! / 60 - movieDetails.runtime! ~/ 60) * 60).toStringAsFixed(0)}m' : 'Unknown'}",
                                                  style: GoogleFonts.inter(
                                                      color: Color(0xffB5B4B4),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                );
                                              }))
                                    ],
                                  ))
                            ]),
                          );
                        },
                      ).toList() ??
                      [],
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 355,
                    disableCenter: false,
                    padEnds: true,
                    viewportFraction: 1,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    width: double.infinity,
                    height: 230,
                    color: AppColors.colorMidBlack,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "New Releases ",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SliderCard(
                                    movieModel: MovieModel(
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        title: '',
                                        releaseDate: '',
                                        path: '',
                                        vote: '',
                                        movieId: '',
                                        isInDatabase: false),
                                    sliderModel: SliderModel(
                                      width: 110,
                                      height: 150,
                                      fraction: .3,
                                      item_card: HomeCubit.get(context)
                                              .newReleases
                                              ?.results ??
                                          [],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ])),
                SizedBox(
                  height: 15,
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    width: double.infinity,
                    height: 290,
                    color: AppColors.colorMidBlack,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Recommended",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: SliderDetailsCard(
                            sliderModel: SliderModel(
                                width: 110,
                                height: 130,
                                fraction: .3,
                                item_card: HomeCubit.get(context)
                                        .recommended
                                        ?.results ??
                                    []),
                          ))
                        ]))
              ],
            ),
          );
        },
      ),
    );
  }
}
