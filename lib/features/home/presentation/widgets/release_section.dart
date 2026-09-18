import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/home/presentation/manager/new_releases_movies/new_releases_cubit.dart';
import 'package:movies_app/features/home/presentation/pages/movie_details.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/web_service/api_constants.dart';

class ReleaseSection extends StatelessWidget {
  const ReleaseSection({super.key, required this.movieEntity});

  final MovieEntity movieEntity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            final releaseMovies = context.read<NewReleasesCubit>().newReleasesMoviesList;
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => MovieDetails(movie: movieEntity,moreLikeMovies: releaseMovies,)));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              ApiConstants.imageBaseUrl + movieEntity.posterPath,
              width: 130.w,
              height: 210.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          child: Container(
            padding: EdgeInsets.all(5.r),
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              color: Color(0xff514F4F)
            ),
            child: Icon(
              Icons.bookmark_add,
              size: 30,
              color: AppColors.textColor,
            ),
          )
        ),
      ],
    );
  }
}
