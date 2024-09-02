import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/MovieDetails.dart';
import 'package:movies_app/models/NewRealeases.dart';
import 'package:movies_app/models/MovieResponse.dart';


class ApiManger{

  static Future<MovieResponse> getPopular()async{
   // https://api.themoviedb.org/3/movie/popular
    Uri url =Uri.https("api.themoviedb.org","/3/movie/popular",);
    http.Response response =await http.get(url,headers:{
      "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDJmNjNmMDEyZmE2MTBjOTQyMTI1YWU3YWZlMTE0ZSIsIm5iZiI6MTcyNDkyMzM1Ni4yNjQxMTUsInN1YiI6IjY2ZDAzMTlmMTVmNTJjYjU0NGQ0MGFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.oM8W5q5UJYF3KdihH0aU_1x5Mz5cprcouMHppY6_gjU"
    });
    var json =jsonDecode(response.body);

    MovieResponse popularResponse =MovieResponse.fromJson(json);
    return popularResponse;
  }


 static Future<NewRealeases>getNewReleases()async{
   // https://api.themoviedb.org/3/movie/upcoming

    Uri url =Uri.https("api.themoviedb.org","/3/movie/upcoming");
    http.Response response =await http.get(url,headers:{
      "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDJmNjNmMDEyZmE2MTBjOTQyMTI1YWU3YWZlMTE0ZSIsIm5iZiI6MTcyNTAwNjQ0OC4wNjI1MzYsInN1YiI6IjY2ZDAzMTlmMTVmNTJjYjU0NGQ0MGFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1FeXR6VcCCEWSwbhhB60laQVRjOW8dqQ_0FNfP8pBj0"
    });

    var json = jsonDecode(response.body);
    NewRealeases newRealeases =NewRealeases.fromJson(json);

  return newRealeases;

  }

  static Future<MovieResponse>getRecommended()async{
    // https://api.themoviedb.org/3/movie/top_rated

    Uri url =Uri.https("api.themoviedb.org","/3/movie/top_rated");
    http.Response response =await http.get(url,headers:{
      "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDJmNjNmMDEyZmE2MTBjOTQyMTI1YWU3YWZlMTE0ZSIsIm5iZiI6MTcyNTAwNjQ0OC4wNjI1MzYsInN1YiI6IjY2ZDAzMTlmMTVmNTJjYjU0NGQ0MGFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1FeXR6VcCCEWSwbhhB60laQVRjOW8dqQ_0FNfP8pBj0"
    });

    var json = jsonDecode(response.body);
    MovieResponse recommended =MovieResponse.fromJson(json);

    return recommended;

  }

  static Future<MovieDetails>getMovieDetails(String movie_id)async{
    //https://api.themoviedb.org/3/movie/{movie_id}
    Uri url =Uri.https("api.themoviedb.org","/3/movie/$movie_id");
    http.Response response =await  http.get(url,headers: {
      "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDJmNjNmMDEyZmE2MTBjOTQyMTI1YWU3YWZlMTE0ZSIsIm5iZiI6MTcyNTAwNjQ0OC4wNjI1MzYsInN1YiI6IjY2ZDAzMTlmMTVmNTJjYjU0NGQ0MGFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1FeXR6VcCCEWSwbhhB60laQVRjOW8dqQ_0FNfP8pBj0"

    });
    var json = jsonDecode(response.body);
    MovieDetails movieDetails = MovieDetails.fromJson(json);
    return movieDetails;
  }

  static Future<MovieResponse>getMoreLikeThis(String movie_id)async{
    //https://api.themoviedb.org/3/movie/{movie_id}/similar
    Uri url =Uri.https("api.themoviedb.org","/3/movie/$movie_id/similar");
    http.Response response =await  http.get(url,headers: {
      "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDJmNjNmMDEyZmE2MTBjOTQyMTI1YWU3YWZlMTE0ZSIsIm5iZiI6MTcyNTEwNjY3My40NDMyMDEsInN1YiI6IjY2ZDAzMTlmMTVmNTJjYjU0NGQ0MGFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1b0khkw8tPt8WKUuXgMCfqvf23NDLINp4tzAkkqMJT4"

    });
    var json = jsonDecode(response.body);
    MovieResponse moreLikeThis = MovieResponse.fromJson(json);
    return moreLikeThis;
  }
  static Future<MovieResponse> searchMovies(String query) async {
    // https://api.themoviedb.org/3/search/movie
    Uri url = Uri.https("api.themoviedb.org", "/3/search/movie", {
      "query": query,
    });

    http.Response response = await http.get(url, headers: {
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDJmNjNmMDEyZmE2MTBjOTQyMTI1YWU3YWZlMTE0ZSIsIm5iZiI6MTcyNTE4NzAwMC42MDM2MjQsInN1YiI6IjY2ZDAzMTlmMTVmNTJjYjU0NGQ0MGFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ECY14mZX9CGlabU5-CaVJrAIDGHnQqH3mxKF6LIw3Co"
    });

    var json = jsonDecode(response.body);


    MovieResponse searchResponse = MovieResponse.fromJson(json);
    return searchResponse;
  }

  static Future<MovieResponse> categoryMovies(String id) async {
    // https://api.themoviedb.org/3/discover/movie?with_genres=16
    Uri url = Uri.https("api.themoviedb.org", "/3/discover/movie", {
      "with_genres": id,
    });

    http.Response response = await http.get(url, headers: {
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDJmNjNmMDEyZmE2MTBjOTQyMTI1YWU3YWZlMTE0ZSIsIm5iZiI6MTcyNTE4NzAwMC42MDM2MjQsInN1YiI6IjY2ZDAzMTlmMTVmNTJjYjU0NGQ0MGFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ECY14mZX9CGlabU5-CaVJrAIDGHnQqH3mxKF6LIw3Co"
    });

    var json = jsonDecode(response.body);


    MovieResponse categoryResponse = MovieResponse.fromJson(json);
    return categoryResponse;
  }





}