import 'package:dio/dio.dart';

abstract class MoviesBaseDataSource {
  Future<Response>getAllPopularMovies();
  Future<Response>getAllNewReleasesMovies();
  Future<Response>getAllUpComingMovies();
  Future<Response>getSearchMovies(String query);
  Future<Response>getGenreMovie();
  Future<Response>getMoviesByGenreID(int genreId);
}