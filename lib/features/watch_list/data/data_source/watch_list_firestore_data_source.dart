import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/features/watch_list/data/data_source/watch_list_data_source.dart';
import 'package:movies_app/features/watch_list/data/models/watch_list_movie_model.dart';

class WatchListFirestoreDataSource implements WatchListDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference get _watchListCollection =>
      firestore.collection("watch_list");

  @override
  Future<void> addMovie(WatchListMovieModel movie) async {
    await _watchListCollection.doc(movie.id.toString()).set(movie.toJson());
  }

  @override
  Future<void> removeMovie(int movieId) async {
    await _watchListCollection.doc(movieId.toString()).delete();
  }

  @override
  Future<List<WatchListMovieModel>> getWatchListMovies() async {
    final snapshot = await _watchListCollection.get();
    List<WatchListMovieModel> movies = [];
    for (var doc in snapshot.docs) {
      movies.add(
        WatchListMovieModel.fromJson(doc.data() as Map<String, dynamic>),
      );
    }
    return movies;
  }

  @override
  Future<bool> isMovieInWatchList(int movieId) async {
    final doc = await _watchListCollection.doc(movieId.toString()).get();
    return doc.exists;
  }
}
