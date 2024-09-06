import 'dart:async';
import 'package:hive/hive.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:path_provider/path_provider.dart';

class CacheWatchList {
  static Future<void> saveWatchList(List<MovieModel> movieModels) async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    var box = await Hive.openBox<MovieModel>('watchList');

    await box.clear();

    for (var movie in movieModels) {
      await box.add(movie);
    }
  }

  static Future<List<MovieModel>> getWatchList() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    var box = await Hive.openBox<MovieModel>('watchList');

    return box.values.toList().cast<MovieModel>();
  }
}
