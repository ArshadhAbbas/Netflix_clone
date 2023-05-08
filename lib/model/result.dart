class Result {
  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    this.title,
    required this.originalLanguage,
    this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  bool adult;
  String backdropPath;
  int id;
  String? title;
  String originalLanguage;
  String? originalTitle;
  String overview;
  String posterPath;
  List<int> genreIds;
  double popularity;
  String? releaseDate;
  bool? video;
  double voteAverage;
  int voteCount;
  String? name;
  String? originalName;
  DateTime? firstAirDate;
  List<String>? originCountry;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        releaseDate: json["release_date"] ,
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
      );

 
}
