import 'dart:async';
import 'package:hive/hive.dart';
import 'package:movies_app/models/MovieResponse.dart';
import 'package:path_provider/path_provider.dart';

class CachePopular {
  static Future<void> savePopular(MovieResponse response) async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'Popular',
      {'popular'},
      path: directory.path,
    );
    final popularBox = await collection.openBox<Map>('popular');
    popularBox.put('popular', response.toJson());
  }

  static Future<MovieResponse> getPopular() async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'Popular',
      {'popular'},
      path: directory.path,
    );
    final popularBox = await collection.openBox<Map>('popular');

    final response = await popularBox.get('popular');
    return MovieResponse.fromJson(response);
  }
}
