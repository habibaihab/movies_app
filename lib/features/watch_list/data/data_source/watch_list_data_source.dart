import 'package:movies_app/features/watch_list/data/models/watch_list_movie_model.dart';

abstract class WatchListDataSource {
  Future<void> addMovie(WatchListMovieModel movie);
  Future<void> removeMovie(int movieId);
  Future<List<WatchListMovieModel>> getWatchListMovies();
  Future<bool> isMovieInWatchList(int movieId);
}
