
class Movie {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final String posterPath;
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }
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


