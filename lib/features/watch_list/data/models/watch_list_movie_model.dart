import 'package:movies_app/features/home/domain/entities/movie_entity.dart';

class WatchListMovieModel extends MovieEntity {
  WatchListMovieModel({
    required super.id,
    required super.backdropPath,
    required super.title,
    required super.overView,
    required super.posterPath,
    required super.date,
    required super.rating,
  });

  factory WatchListMovieModel.fromEntity(MovieEntity movie) {
    return WatchListMovieModel(
      id: movie.id,
      backdropPath: movie.backdropPath,
      title: movie.title,
      overView: movie.overView,
      posterPath: movie.posterPath,
      date: movie.date,
      rating: movie.rating,
    );
  }

  factory WatchListMovieModel.fromJson(Map<String, dynamic> json) {
    return WatchListMovieModel(
      id: json["id"] ?? 0,
      backdropPath: json["backdropPath"] ?? "",
      title: json["title"] ?? "",
      overView: json["overView"] ?? "",
      posterPath: json["posterPath"] ?? "",
      date: json["date"] ?? "",
      rating: (json["rating"] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "backdropPath": backdropPath,
      "title": title,
      "overView": overView,
      "posterPath": posterPath,
      "date": date,
      "rating": rating,
    };
  }
}
