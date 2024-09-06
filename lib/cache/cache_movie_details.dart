import 'dart:async';
import 'package:hive/hive.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:path_provider/path_provider.dart';

class CacheMovieDetails {
  static Future<void> saveMovieDetails(MovieDetails response) async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'MovieDetails',
      {'movieDetails'},
      path: directory.path,
    );
    final movieDetailsBox = await collection.openBox<Map>('movieDetails');
    movieDetailsBox.put('movieDetails', response.toJson());
  }

  static Future<MovieDetails> getMovieDetails() async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'MovieDetails',
      {'movieDetails'},
      path: directory.path,
    );
    final movieDetailsBox = await collection.openBox<Map>('movieDetails');

    final response = await movieDetailsBox.get('movieDetails');
    return MovieDetails.fromJson(response);
  }
}
