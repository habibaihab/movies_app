import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/movie_entity.dart';

abstract class UpComingRepo{
  Future<Either<Failure,List<MovieEntity>>>getUpComingMovies();

}