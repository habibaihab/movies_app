import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/core/web_service/api_service.dart';
import 'package:movies_app/features/home/data/data_source/movies_base_data_source.dart';
import 'package:movies_app/features/home/data/data_source/remote_popular_movies.dart';
import 'package:movies_app/features/home/data/repository_imp/up_coming_repo_imp.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/home/domain/repository/up_coming_repo.dart';
import 'package:movies_app/features/home/domain/use_cases/up_coming_use_case.dart';

part 'up_coming_state.dart';

class UpComingCubit extends Cubit<UpComingState> {
  UpComingCubit() : super(UpComingInitial()){
    getUpComingMovies();
  }

  late UpComingUseCase upComingUseCase;
  late UpComingRepo upComingRepo;
  late MoviesBaseDataSource moviesBaseDataSource;
  late ApiService apiService;

  List<MovieEntity> _upComingMoviesList = [];
  List<MovieEntity> get upComingMovies => _upComingMoviesList;

  Future<void>getUpComingMovies() async{


    apiService = ApiService();
    moviesBaseDataSource = RemoteGetMovies(apiService);
    upComingRepo = UpComingRepoImp(moviesBaseDataSource);
    upComingUseCase = UpComingUseCase(upComingRepo);

    emit(UpComingLoading());

    final result =  await upComingUseCase.execute();

    return result.fold((error){
      emit(UpComingFailed(error.message));
    },
        (data){

      _upComingMoviesList = data ;
      emit(UpComingSuccess());
        });

  }
}
