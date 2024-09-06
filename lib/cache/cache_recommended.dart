import 'dart:async';
import 'package:hive/hive.dart';
import 'package:movies_app/models/MovieResponse.dart';
import 'package:path_provider/path_provider.dart';

class CacheRecommended {
  static Future<void> saveRecommended(MovieResponse response) async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'Recommended',
      {'recommended'},
      path: directory.path,
    );
    final recommendedBox = await collection.openBox<Map>('recommended');
    recommendedBox.put('recommended', response.toJson());
  }

  static Future<MovieResponse> getRecommended() async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'Recommended',
      {'recommended'},
      path: directory.path,
    );
    final recommendedBox = await collection.openBox<Map>('recommended');

    final response = await recommendedBox.get('recommended');
    return MovieResponse.fromJson(response);
  }
}
