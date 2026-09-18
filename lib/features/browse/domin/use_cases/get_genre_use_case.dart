import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/browse/domin/entities/genre_entity.dart';
import 'package:movies_app/features/browse/domin/repositry/get_genre_repo.dart';

import '../../../home/domain/entities/movie_entity.dart';

class GetGenreUseCase {
  final GetGenreRepo getGenreRepo;

  GetGenreUseCase(this.getGenreRepo);

  Future<Either<Failure,List<GenreEntity>>> execute() async{

    return await getGenreRepo.getGenreMovie();

  }

  Future<Either<Failure, List<MovieEntity>>> getMoviesByGenreId( int genreId ) async {
    return await getGenreRepo.getMoviesByGenreId(genreId);
  }
}