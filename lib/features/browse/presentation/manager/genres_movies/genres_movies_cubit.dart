import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/core/web_service/api_service.dart';
import 'package:movies_app/features/browse/data/repositry_imp/get_genre_repo_imp.dart';
import 'package:movies_app/features/browse/domin/entities/genre_entity.dart';
import 'package:movies_app/features/browse/domin/repositry/get_genre_repo.dart';
import 'package:movies_app/features/browse/domin/use_cases/get_genre_use_case.dart';
import 'package:movies_app/features/home/data/data_source/movies_base_data_source.dart';
import 'package:movies_app/features/home/data/data_source/remote_popular_movies.dart';

part 'genres_movies_state.dart';

class GenresMoviesCubit extends Cubit<GenresMoviesState> {
  GenresMoviesCubit() : super(GenresMoviesInitial()){
    getGenresMovies();
  }

  late GetGenreUseCase genreUseCase;
  late GetGenreRepo getGenreRepo;
  late MoviesBaseDataSource moviesBaseDataSource;
  late ApiService apiService;

  List<GenreEntity> _genresMoviesList = [];
  List<GenreEntity> get genresMoviesList => _genresMoviesList;

  Future<void> getGenresMovies() async{

    apiService = ApiService();
    moviesBaseDataSource = RemoteGetMovies(apiService);
    getGenreRepo = GetGenreRepoImp(moviesBaseDataSource);
    genreUseCase = GetGenreUseCase(getGenreRepo);

    emit(GenresMoviesLoading());


    final result = await genreUseCase.execute();

    return result.fold((error){

      emit(GenresMoviesFailed("Failed To Get Data"));
    }, (data){
      _genresMoviesList = data;

      if(data.isEmpty){
        emit(GenresMoviesEmpty());
      } else{
        emit(GenresMoviesSuccess());
      }


    });

  }

}
