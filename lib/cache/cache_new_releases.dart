import 'dart:async';
import 'package:hive/hive.dart';
import 'package:movies_app/models/NewReleases.dart';
import 'package:path_provider/path_provider.dart';

class CacheNewReleases {
  static Future<void> saveNewReleases(NewRealeases response) async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'NewReleases',
      {'newReleases'},
      path: directory.path,
    );
    final NewRealeasesBox = await collection.openBox<Map>('newReleases');
    NewRealeasesBox.put('newReleases', response.toJson());
  }

  static Future<NewRealeases> getNewReleases() async {
    final directory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'NewReleases',
      {'newReleases'},
      path: directory.path,
    );
    final NewRealeasesBox = await collection.openBox<Map>('newReleases');

    final response = await NewRealeasesBox.get('newReleases');
    return NewRealeases.fromJson(response);
  }
}
