import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/data/data_source/movies_base_data_source.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/home/domain/repository/up_coming_repo.dart';

class UpComingRepoImp implements UpComingRepo{
  final MoviesBaseDataSource moviesBaseDataSource;

  UpComingRepoImp(this.moviesBaseDataSource);
  @override
  Future<Either<Failure, List<MovieEntity>>> getUpComingMovies() async {
    try{
      final res = await moviesBaseDataSource.getAllUpComingMovies();

      List<MovieModel>movies = [];
      if(res.statusCode == 200){

        var data = res.data["results"];
        for(var obj in data){
          movies.add(MovieModel.fromJson(obj));
        }

        return Right(movies);

      }else {

        return Left(ServerError(res.statusCode.toString()));
      }

    }on DioException catch(dioException){
      return Left(
        ServerError(
          dioException.response!.statusCode.toString()
        )
      );
    }
  }
}