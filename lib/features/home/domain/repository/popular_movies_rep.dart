import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';

abstract class PopularMoviesRep {
  Future<Either<Failure,List<MovieEntity>>>getPopularMovies();
}