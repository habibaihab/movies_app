import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import '../../../../../core/web_service/api_service.dart';
import '../../../../home/data/data_source/movies_base_data_source.dart';
import '../../../../home/data/data_source/remote_popular_movies.dart';
import '../../../data/repositry_imp/get_genre_repo_imp.dart';
import '../../../domin/repositry/get_genre_repo.dart';
import '../../../domin/use_cases/get_genre_use_case.dart';

part 'get_movies_by_genre_id_state.dart';

class GetMoviesByGenreIdCubit extends Cubit<GetMoviesByGenreIdState> {
  GetMoviesByGenreIdCubit() : super(GetMoviesByGenreIdInitial());
  late GetGenreUseCase genreUseCase;
  late GetGenreRepo getGenreRepo;
  late MoviesBaseDataSource moviesBaseDataSource;
  late ApiService apiService;

  List<MovieEntity> _moviesList = [];
  List<MovieEntity> get moviesList => _moviesList;

  Future<void> getMoviesByGenreId(int genreId) async{

    apiService = ApiService();
    moviesBaseDataSource = RemoteGetMovies(apiService);
    getGenreRepo = GetGenreRepoImp(moviesBaseDataSource);
    genreUseCase = GetGenreUseCase(getGenreRepo);

    emit(GetMoviesByGenreIdLoading());


    final result = await genreUseCase.getMoviesByGenreId(genreId);

    return result.fold((error){

      emit(GetMoviesByGenreIdFailed("Failed To Get Data"));
    }, (data){
      _moviesList = data;

      if(data.isEmpty){
        emit(GetMoviesByGenreIdEmpty());
      } else{
        emit(GetMoviesByGenreIdSuccess());
      }


    });

  }
}
