
class Movie{
  String title;
  String backDropPath;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  double voteAverage;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,

});
  factory Movie.fromJason(Map<String, dynamic> json){
    return Movie(
        title: json["title"],
        backDropPath: json["backdrop_path"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        voteAverage: json["vote_average"]
    );
  }
  //If you want to post into the api
  // Map<String, dynamic> toJson()=>{
  //   "title":title,
  //   "overview":overview,
  // };

  //If you want to post into the api
  // Map<String, dynamic> toJson()=>{
  //   "title":title,
  //   "overview":overview,
  // };
}
