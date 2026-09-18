import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/core/web_service/api_service.dart';
import 'package:movies_app/features/home/data/data_source/movies_base_data_source.dart';
import 'package:movies_app/features/home/data/data_source/remote_popular_movies.dart';
import 'package:movies_app/features/home/data/repository_imp/popular_movies_rep_imp.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/home/domain/repository/popular_movies_rep.dart';
import 'package:movies_app/features/home/domain/use_cases/popular_movies_use_case.dart';

part 'get_movies_state.dart';

class GetMoviesCubit extends Cubit<GetMoviesState> {
  GetMoviesCubit() : super(GetMoviesInitial()){
    print("Cubit Created");
    getPopularMovies();

  }

  late PopularMoviesUseCase popularMoviesUseCase;
  late PopularMoviesRep popularMoviesRep ;
  late MoviesBaseDataSource moviesBaseDataSource;
  late ApiService apiService;

  List<MovieEntity> _popularMoviesList = [];
  List<MovieEntity> get popularMoviesList => _popularMoviesList;
  
  Future<void> getPopularMovies()async{

    apiService =ApiService();
    moviesBaseDataSource = RemoteGetMovies(apiService);
    popularMoviesRep =PopularMoviesRepImp(moviesBaseDataSource);
    popularMoviesUseCase = PopularMoviesUseCase(popularMoviesRep);

    emit(LoadingGetMovies());

    final result = await popularMoviesUseCase.execute();
    print(result);

    return result.fold((l){
      emit(ErrorGetMovies(l.message));
    }, (data){
      _popularMoviesList = data;
      emit(SuccessGetMovies());
      
    });
    

  }
}
