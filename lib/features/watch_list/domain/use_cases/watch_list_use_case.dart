import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/watch_list/domain/repository/watch_list_repo.dart';

class WatchListUseCase {
  WatchListRepo watchListRepo;

  WatchListUseCase(this.watchListRepo);

  Future<Either<Failure, void>> addMovie(MovieEntity movie) async {
    return await watchListRepo.addMovie(movie);
  }

  Future<Either<Failure, void>> removeMovie(int movieId) async {
    return await watchListRepo.removeMovie(movieId);
  }

  Future<Either<Failure, List<MovieEntity>>> getWatchListMovies() async {
    return await watchListRepo.getWatchListMovies();
  }

  Future<Either<Failure, bool>> isMovieInWatchList(int movieId) async {
    return await watchListRepo.isMovieInWatchList(movieId);
  }
}
