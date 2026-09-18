import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';

abstract class WatchListRepo {
  Future<Either<Failure, void>> addMovie(MovieEntity movie);
  Future<Either<Failure, void>> removeMovie(int movieId);
  Future<Either<Failure, List<MovieEntity>>> getWatchListMovies();
  Future<Either<Failure, bool>> isMovieInWatchList(int movieId);
}
