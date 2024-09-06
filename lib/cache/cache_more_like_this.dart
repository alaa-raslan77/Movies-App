import 'dart:async';
import 'package:hive/hive.dart';
import 'package:movies_app/models/MovieResponse.dart';
import 'package:path_provider/path_provider.dart';

class CacheMoreLikeThis {
  static Future<void> saveMoreLikeThis(MovieResponse response) async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'MoreLikeThis',
      {'moreLikeThis'},
      path: directory.path,
    );
    final moreLikeThisBox = await collection.openBox<Map>('moreLikeThis');
    moreLikeThisBox.put('moreLikeThis', response.toJson());
  }

  static Future<MovieResponse> getMoreLikeThis() async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'MoreLikeThis',
      {'moreLikeThis'},
      path: directory.path,
    );
    final moreLikeThisBox = await collection.openBox<Map>('moreLikeThis');

    final response = await moreLikeThisBox.get('moreLikeThis');
    return MovieResponse.fromJson(response);
  }
}
