import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/core/web_service/api_service.dart';
import 'package:movies_app/features/home/data/data_source/movies_base_data_source.dart';
import 'package:movies_app/features/home/data/data_source/remote_popular_movies.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/search/data/repository_imp/search_repo_imp.dart';
import 'package:movies_app/features/search/domain/repository/search_repo.dart';
import 'package:movies_app/features/search/domain/use_cases/search_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  late SearchUseCase searchUseCase;
  late SearchRepo searchRepo;
  late MoviesBaseDataSource moviesBaseDataSource;
  late ApiService apiService;

  List<MovieEntity> _searchMoviesList = [];
  List<MovieEntity> get searchMoviesList => _searchMoviesList;

  Future<void> getSearchMovies(String query) async {
    if (query.trim().isEmpty) {
      _searchMoviesList = [];
      emit(SearchInitial());
      return;
    }

    apiService = ApiService();
    moviesBaseDataSource = RemoteGetMovies(apiService);
    searchRepo = SearchRepoImp(moviesBaseDataSource);
    searchUseCase = SearchUseCase(searchRepo);

    emit(SearchLoading());

    final result = await searchUseCase.execute(query.trim());

    return result.fold((error) {
      emit(SearchError(error.message));
    }, (data) {
      _searchMoviesList = data;
      if (data.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchSuccess());
      }
    });
  }
}
