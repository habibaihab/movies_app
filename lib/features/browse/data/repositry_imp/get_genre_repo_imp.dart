import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/browse/data/models/genre_model.dart';
import 'package:movies_app/features/browse/domin/entities/genre_entity.dart';
import 'package:movies_app/features/browse/domin/repositry/get_genre_repo.dart';
import 'package:movies_app/features/home/data/data_source/movies_base_data_source.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';

class GetGenreRepoImp implements GetGenreRepo{

  final MoviesBaseDataSource moviesBaseDataSource;

  GetGenreRepoImp(this.moviesBaseDataSource);

  @override
  Future<Either<Failure, List<GenreEntity>>> getGenreMovie() async{
    try{

      final response = await  moviesBaseDataSource.getGenreMovie();

      List<GenreModel> genreData= [];

      if(response.statusCode == 200){
        var data = response.data["genres"];

        for(var ele in data){
          genreData.add(GenreModel.fromJson(ele));
        }
        return Right(genreData);
      }else {
        return Left(ServerError(response.statusCode.toString()));
      }
    }on DioException catch(e){

      return Left(ServerError(e.response!.statusCode.toString()));

    }

  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getMoviesByGenreId(int genreId) async {

    try{

      final response = await moviesBaseDataSource.getMoviesByGenreID(genreId);

      List<MovieModel> moviesData = [];

      if(response.statusCode ==200){

        var data = response.data["results"];

        for(var ele in data){
          moviesData.add(MovieModel.fromJson(ele));
        }

        return Right(moviesData);
      }else{
        return Left(ServerError(response.statusCode.toString()));
      }

    }on DioException catch(e){

      return Left(ServerError(e.response!.statusCode.toString()));

    }

  }

}