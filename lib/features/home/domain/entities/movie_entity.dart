import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String backdropPath;

  final String title;
  final String overView;
  final String posterPath;
  final String date;
  final double rating;

  MovieEntity({
    required this.id,
    required this.backdropPath
    , required this.title, required this.overView, required
    this.posterPath, required this.date, required this.rating});

  @override
  List<Object> get props =>
      [id, backdropPath, title, overView, posterPath, date, rating,];
}