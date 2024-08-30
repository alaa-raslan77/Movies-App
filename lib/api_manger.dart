import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/PopularResponse.dart';

class ApiManger{

  Future<PopularResponse> getPopular()async{

   // https://api.themoviedb.org/3/movie/popular
    Uri url =Uri.https("api.themoviedb.org","/3/movie/popular",
        {"apiKey": "302f63f012fa610c942125ae7afe114e"});
    http.Response response =await http.get(url);
    var json =jsonDecode(response.body);
    
    PopularResponse popularResponse =PopularResponse.fromJson(json);
    return popularResponse;

  }


}