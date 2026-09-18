import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/watch_list/data/data_source/watch_list_data_source.dart';
import 'package:movies_app/features/watch_list/data/data_source/watch_list_firestore_data_source.dart';
import 'package:movies_app/features/watch_list/data/repository_imp/watch_list_repo_imp.dart';
import 'package:movies_app/features/watch_list/domain/repository/watch_list_repo.dart';
import 'package:movies_app/features/watch_list/domain/use_cases/watch_list_use_case.dart';

part 'watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit() : super(WatchListInitial()) {
    getWatchListMovies();
  }

  late WatchListUseCase watchListUseCase;
  late WatchListRepo watchListRepo;
  late WatchListDataSource watchListDataSource;

  List<MovieEntity> _watchListMovies = [];
  List<MovieEntity> get watchListMovies => _watchListMovies;

  void _initDependencies() {
    watchListDataSource = WatchListFirestoreDataSource();
    watchListRepo = WatchListRepoImp(watchListDataSource);
    watchListUseCase = WatchListUseCase(watchListRepo);
  }

  bool isInWatchList(int movieId) {
    return _watchListMovies.any((movie) => movie.id == movieId);
  }

  Future<void> getWatchListMovies() async {
    _initDependencies();
    emit(WatchListLoading());

    final result = await watchListUseCase.getWatchListMovies();

    return result.fold((error) {
      emit(WatchListError(error.message));
    }, (data) {
      _watchListMovies = data;
      if (data.isEmpty) {
        emit(WatchListEmpty());
      } else {
        emit(WatchListSuccess());
      }
    });
  }

  Future<void> toggleWatchList(MovieEntity movie) async {
    _initDependencies();

    if (isInWatchList(movie.id)) {
      final result = await watchListUseCase.removeMovie(movie.id);
      return result.fold((error) {
        emit(WatchListError(error.message));
      }, (_) {
        _watchListMovies.removeWhere((item) => item.id == movie.id);
        if (_watchListMovies.isEmpty) {
          emit(WatchListEmpty());
        } else {
          emit(WatchListSuccess());
        }
      });
    } else {
      final result = await watchListUseCase.addMovie(movie);
      return result.fold((error) {
        emit(WatchListError(error.message));
      }, (_) {
        _watchListMovies.add(movie);
        emit(WatchListSuccess());
      });
    }
  }
}
