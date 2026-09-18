import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/features/home/data/data_source/remote_popular_movies.dart';
import 'package:movies_app/features/home/data/repository_imp/new_releases_repo_imp.dart';
import 'package:movies_app/features/home/domain/repository/new_releases_repo.dart';
import 'package:movies_app/features/home/domain/use_cases/new_releases_use_case.dart';

import '../../../../../core/web_service/api_service.dart';
import '../../../data/data_source/movies_base_data_source.dart';
import '../../../domain/entities/movie_entity.dart';

part 'new_releases_state.dart';

class NewReleasesCubit extends Cubit<NewReleasesState> {
  NewReleasesCubit() : super(NewReleasesInitial()){
    getNewReleasesMovies();
  }

    late NewReleasesUseCase newReleasesUseCase;
    late NewReleasesRepo newReleasesRepo ;
    late MoviesBaseDataSource moviesBaseDataSource;
    late ApiService apiService;
    List<MovieEntity> _newReleaseMoviesList = [];
    List<MovieEntity> get newReleasesMoviesList => _newReleaseMoviesList;

  Future<void> getNewReleasesMovies()async {
    apiService = ApiService();
    moviesBaseDataSource = RemoteGetMovies(apiService);
    newReleasesRepo = NewReleasesRepoImp(moviesBaseDataSource);
    newReleasesUseCase = NewReleasesUseCase(newReleasesRepo);
    emit(LoadingNewReleasesMovies());

    final result = await newReleasesUseCase.execute();

    return result.fold((error){
      emit(ErrorNewReleasesMovies(error.message));

    }, (data){
      _newReleaseMoviesList = data;
      emit(SuccessNewReleasesMovies());
    });



  }

}
