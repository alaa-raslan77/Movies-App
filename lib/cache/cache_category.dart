import 'dart:async';
import 'package:hive/hive.dart';
import 'package:movies_app/models/MovieResponse.dart';
import 'package:path_provider/path_provider.dart';

class CacheCategory {
  static Future<void> saveCategory(MovieResponse response) async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'Category',
      {'category'},
      path: directory.path,
    );
    final categoryBox = await collection.openBox<Map>('category');
    categoryBox.put('category', response.toJson());
  }

  static Future<MovieResponse> getCategory() async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'Category',
      {'category'},
      path: directory.path,
    );
    final categoryBox = await collection.openBox<Map>('category');

    final response = await categoryBox.get('category');
    return MovieResponse.fromJson(response);
  }
}
