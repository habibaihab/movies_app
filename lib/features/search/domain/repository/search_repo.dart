import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<MovieEntity>>> getSearchMovies(String query);
}
