import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/data/data_source/movies_base_data_source.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/search/domain/repository/search_repo.dart';

class SearchRepoImp implements SearchRepo {
  final MoviesBaseDataSource moviesBaseDataSource;

  SearchRepoImp(this.moviesBaseDataSource);

  @override
  Future<Either<Failure, List<MovieEntity>>> getSearchMovies(String query) async {
    try {
      final response = await moviesBaseDataSource.getSearchMovies(query);

      List<MovieEntity> moviesData = [];
      if (response.statusCode == 200) {
        var data = response.data["results"];
        for (var ele in data) {
          moviesData.add(MovieModel.fromJson(ele));
        }
        return Right(moviesData);
      } else {
        return Left(
          ServerError(response.statusCode.toString()),
        );
      }
    } on DioException catch (dioException) {
      return Left(
        ServerError(dioException.response!.statusCode.toString()),
      );
    }
  }
}
