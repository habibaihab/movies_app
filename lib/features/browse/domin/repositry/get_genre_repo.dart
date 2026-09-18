import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/browse/domin/entities/genre_entity.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';

abstract class GetGenreRepo {
  Future<Either<Failure,List<GenreEntity>>>getGenreMovie();
  Future<Either<Failure,List<MovieEntity>>>getMoviesByGenreId(int genreId);
}