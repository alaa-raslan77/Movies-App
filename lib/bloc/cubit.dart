import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:movies_app/bloc/states.dart';
import 'package:http/http.dart' as http;

import '../models/MovieResponse.dart';
import '../models/NewRealeases.dart';

class HomeCubit extends Cubit<HomeState>{

  HomeCubit():super(HomeInitState());

  MovieResponse? popularResponse;
  NewRealeases?  newReleases;
  MovieResponse? recommended;


   Future<void> getPopular()async{
    try{
      emit(HomeGetPopularLoadingState());
      // https://api.themoviedb.org/3/movie/popular
      Uri url =Uri.https("api.themoviedb.org","/3/movie/popular",);
      http.Response response =await http.get(url,headers:{
        "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDJmNjNmMDEyZmE2MTBjOTQyMTI1YWU3YWZlMTE0ZSIsIm5iZiI6MTcyNDkyMzM1Ni4yNjQxMTUsInN1YiI6IjY2ZDAzMTlmMTVmNTJjYjU0NGQ0MGFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.oM8W5q5UJYF3KdihH0aU_1x5Mz5cprcouMHppY6_gjU"
      });
      var json =jsonDecode(response.body);

      popularResponse =MovieResponse.fromJson(json);
      emit(HomeGetPopularSuccessState());
    }catch(e){
      emit(HomeGetPopularErrorState());
    }

  }


   Future<void>getNewReleases()async{
    try{
      emit(HomeGetNewReleasesLoadingState());
      // https://api.themoviedb.org/3/movie/upcoming

      Uri url =Uri.https("api.themoviedb.org","/3/movie/upcoming");
      http.Response response =await http.get(url,headers:{
        "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDJmNjNmMDEyZmE2MTBjOTQyMTI1YWU3YWZlMTE0ZSIsIm5iZiI6MTcyNTAwNjQ0OC4wNjI1MzYsInN1YiI6IjY2ZDAzMTlmMTVmNTJjYjU0NGQ0MGFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1FeXR6VcCCEWSwbhhB60laQVRjOW8dqQ_0FNfP8pBj0"
      });

      var json = jsonDecode(response.body);
      newReleases =NewRealeases.fromJson(json);
      emit(HomeGetNewReleasesErrorState());



    }catch(e){
      emit(HomeGetNewReleasesErrorState());
    }

  }


   Future<void>getRecommended()async{
    try{
      emit(HomeGetRecommendedLoadingState());

      // https://api.themoviedb.org/3/movie/top_rated

      Uri url =Uri.https("api.themoviedb.org","/3/movie/top_rated");
      http.Response response =await http.get(url,headers:{
        "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDJmNjNmMDEyZmE2MTBjOTQyMTI1YWU3YWZlMTE0ZSIsIm5iZiI6MTcyNTAwNjQ0OC4wNjI1MzYsInN1YiI6IjY2ZDAzMTlmMTVmNTJjYjU0NGQ0MGFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1FeXR6VcCCEWSwbhhB60laQVRjOW8dqQ_0FNfP8pBj0"
      });

      var json = jsonDecode(response.body);
      recommended =MovieResponse.fromJson(json);
      emit(HomeGetRecommendedSuccessState());


    }catch(e){
      emit(HomeGetRecommendedErrorState());
    }


  }







}