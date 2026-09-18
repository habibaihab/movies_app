import 'package:movies_app/features/home/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity{
  MovieModel({
    required super.id,
    required super.backdropPath,
    required super.title,
    required super.overView,
    required super.posterPath,
    required super.date,
    required super.rating});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"] ?? 0,
      backdropPath: json["backdrop_path"] ?? "",
      title: json["title"] ?? "",
      overView: json["overview"] ?? "",
      posterPath: json["poster_path"] ?? "",
      date: json["release_date"] ?? "",
      rating: (json["vote_average"] ?? 0).toDouble(),
    );
  }


}