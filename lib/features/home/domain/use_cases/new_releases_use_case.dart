import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/home/domain/repository/new_releases_repo.dart';

class NewReleasesUseCase {
  NewReleasesRepo newReleasesRepo;

  NewReleasesUseCase(this.newReleasesRepo);

  Future<Either<Failure,List<MovieEntity>>> execute() async{

    return await newReleasesRepo.getNewReleasesMovies();


  }
}