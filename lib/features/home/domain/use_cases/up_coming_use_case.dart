import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failures.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/home/domain/repository/up_coming_repo.dart';

class UpComingUseCase {
  final UpComingRepo upComingRepo;
  UpComingUseCase(this.upComingRepo);

  Future<Either<Failure,List<MovieEntity>>>execute() async{

    return await upComingRepo.getUpComingMovies();

  }

}