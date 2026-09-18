import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/watch_list/data/data_source/watch_list_data_source.dart';
import 'package:movies_app/features/watch_list/data/models/watch_list_movie_model.dart';
import 'package:movies_app/features/watch_list/domain/repository/watch_list_repo.dart';

class WatchListRepoImp implements WatchListRepo {
  final WatchListDataSource watchListDataSource;

  WatchListRepoImp(this.watchListDataSource);

  @override
  Future<Either<Failure, void>> addMovie(MovieEntity movie) async {
    try {
      await watchListDataSource.addMovie(
        WatchListMovieModel.fromEntity(movie),
      );
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerError(e.message ?? e.code));
    }
  }

  @override
  Future<Either<Failure, void>> removeMovie(int movieId) async {
    try {
      await watchListDataSource.removeMovie(movieId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerError(e.message ?? e.code));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getWatchListMovies() async {
    try {
      final movies = await watchListDataSource.getWatchListMovies();
      return Right(movies);
    } on FirebaseException catch (e) {
      return Left(ServerError(e.message ?? e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> isMovieInWatchList(int movieId) async {
    try {
      final isSaved = await watchListDataSource.isMovieInWatchList(movieId);
      return Right(isSaved);
    } on FirebaseException catch (e) {
      return Left(ServerError(e.message ?? e.code));
    }
  }
}
