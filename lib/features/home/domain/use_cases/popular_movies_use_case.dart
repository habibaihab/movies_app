import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/home/domain/repository/popular_movies_rep.dart';

class PopularMoviesUseCase {
  PopularMoviesRep popularMoviesRep;

  PopularMoviesUseCase(this.popularMoviesRep);
   Future<Either<Failure,List<MovieEntity>>> execute()async{
    return await popularMoviesRep.getPopularMovies();
  }

}