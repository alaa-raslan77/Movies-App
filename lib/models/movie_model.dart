import 'package:hive/hive.dart';
part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends HiveObject {
  @HiveField(0)
  String movieId;
  @HiveField(1)
  String id;
  @HiveField(2)
  String title;
  @HiveField(3)
  String releaseDate;
  @HiveField(4)
  String vote;
  @HiveField(5)
  String path;
  @HiveField(6)
  bool isInDatabase;
  @HiveField(7)
  String uid;

  MovieModel(
      {required this.title,
      required this.releaseDate,
      required this.path,
      required this.vote,
      required this.movieId,
      this.id = "",
      required this.uid,
      this.isInDatabase = false});

  MovieModel.fromJson(dynamic json)
      : this(
          title: json['title']??'',
          releaseDate: json['releaseDate']??'',
          path: json['path']??'',
          vote: json['vote']??'',
          movieId: json['movieId']??'',
          isInDatabase: json['isInDatabase'],
          id: json['id']??'',
          uid: json['uid']??'',
        );

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "releaseDate": releaseDate,
      "path": path,
      "vote": vote,
      "movieId": movieId,
      "isInDatabase": isInDatabase,
      "id": id,
      "uid": uid,
    };
  }
}
