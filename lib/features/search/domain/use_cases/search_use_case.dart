import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/search/domain/repository/search_repo.dart';

class SearchUseCase {
  SearchRepo searchRepo;

  SearchUseCase(this.searchRepo);

  Future<Either<Failure, List<MovieEntity>>> execute(String query) async {
    return await searchRepo.getSearchMovies(query);
  }
}
