import 'MovieResponse.dart';



class NewRealeases {
  NewRealeases({
      Dates? dates, 
      num? page, 
      List<Results>? results, 
      num? totalPages, 
      num? totalResults,}){
    _dates = dates;
    _page = page;
    _results = results;
    _totalPages = totalPages;
    _totalResults = totalResults;
}

  NewRealeases.fromJson(dynamic json) {
    _dates = json['dates'] != null ? Dates.fromJson(json['dates']) : null;
    _page = json['page'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
    _totalPages = json['total_pages'];
    _totalResults = json['total_results'];
  }
  Dates? _dates;
  num? _page;
  List<Results>? _results;
  num? _totalPages;
  num? _totalResults;
NewRealeases copyWith({  Dates? dates,
  num? page,
  List<Results>? results,
  num? totalPages,
  num? totalResults,
}) => NewRealeases(  dates: dates ?? _dates,
  page: page ?? _page,
  results: results ?? _results,
  totalPages: totalPages ?? _totalPages,
  totalResults: totalResults ?? _totalResults,
);
  Dates? get dates => _dates;
  num? get page => _page;
  List<Results>? get results => _results;
  num? get totalPages => _totalPages;
  num? get totalResults => _totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_dates != null) {
      map['dates'] = _dates?.toJson();
    }
    map['page'] = _page;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = _totalPages;
    map['total_results'] = _totalResults;
    return map;
  }

}

/// adult : false
/// backdrop_path : "/tabKOXkHRu6Nho2VOYrnyAirtY7.jpg"
/// genre_ids : [80,27,53]
/// id : 1226578
/// original_language : "en"
/// original_title : "Longlegs"
/// overview : "FBI Agent Lee Harker is assigned to an unsolved serial killer case that takes an unexpected turn, revealing evidence of the occult. Harker discovers a personal connection to the killer and must stop him before he strikes again."
/// popularity : 1299.181
/// poster_path : "/5aj8vVGFwGVbQQs26ywhg4Zxk2L.jpg"
/// release_date : "2024-07-10"
/// title : "Longlegs"
/// video : false
/// vote_average : 6.591
/// vote_count : 502



/// maximum : "2024-09-25"
/// minimum : "2024-09-04"

class Dates {
  Dates({
      String? maximum, 
      String? minimum,}){
    _maximum = maximum;
    _minimum = minimum;
}

  Dates.fromJson(dynamic json) {
    _maximum = json['maximum'];
    _minimum = json['minimum'];
  }
  String? _maximum;
  String? _minimum;
Dates copyWith({  String? maximum,
  String? minimum,
}) => Dates(  maximum: maximum ?? _maximum,
  minimum: minimum ?? _minimum,
);
  String? get maximum => _maximum;
  String? get minimum => _minimum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maximum'] = _maximum;
    map['minimum'] = _minimum;
    return map;
  }

}