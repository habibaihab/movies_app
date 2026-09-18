import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/movie_entity.dart';

abstract class NewReleasesRepo {
  Future<Either<Failure,List<MovieEntity>>>getNewReleasesMovies();

}