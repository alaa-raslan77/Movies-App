class MovieModel {
  String movieId;
  String id;
  String title;
  String releaseDate;
  String vote;
  String path;
  bool isInDatabase;
  String uid;

  MovieModel({required this.title,
    required this.releaseDate,
    required this.path,
    required this.vote,
    required this.movieId,
    this.id="",
    required this.uid,

  this.isInDatabase=false});


  MovieModel.fromJson(Map<String, dynamic>json) :this(
      title: json['title'],
      releaseDate: json['releaseDate'],
      path: json['path'],
      vote: json['vote'],
      movieId: json['movieId'],
      isInDatabase: json['isInDatabase'],
    id: json['id'],
    uid: json['uid'],

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
