import 'package:dio/src/response.dart';
import 'package:movies_app/core/web_service/api_constants.dart';
import 'package:movies_app/core/web_service/api_service.dart';
import 'package:movies_app/features/home/data/data_source/movies_base_data_source.dart';

class RemoteGetMovies implements MoviesBaseDataSource{
  final ApiService apiService;

  RemoteGetMovies(this.apiService);

  @override
  Future<Response> getAllPopularMovies() async {
   return  await apiService.dio.get(ApiConstants.baseUrl+ApiConstants.popularEndPoint);
  }

  @override
  Future<Response> getAllNewReleasesMovies() async {
    return  await apiService.dio.get(ApiConstants.baseUrl+ApiConstants.topRatedEndPoint);
  }
  @override
  Future<Response> getAllUpComingMovies() async {
    return  await apiService.dio.get(ApiConstants.baseUrl+ApiConstants.topRatedEndPoint);
  }

  @override
  Future<Response> getSearchMovies(String query) async {
    return await apiService.dio.get(
      ApiConstants.baseUrl+ApiConstants.searchMovieUrl,
      queryParameters: {
        "query": query,
        "include_adult": false,
        "language": "en-US",
        "page": 1,
      },
    );
  }

  @override
  Future<Response<dynamic>> getGenreMovie() async{
   return  await apiService.dio.get(
     ApiConstants.baseUrl+ApiConstants.genreMovieUrl
   );
  }

  @override
  Future<Response<dynamic>> getMoviesByGenreID(int genreId) async {
    return await apiService.dio.get(
      ApiConstants.baseUrl+ApiConstants.moviesWithGenreUrl,
      queryParameters: {
        'with_genres':genreId
      }
    );
  }
}