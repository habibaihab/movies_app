import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/web_service/api_constants.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/home/presentation/pages/movie_details.dart';
import 'package:movies_app/features/search/presentation/manager/search_movies/search_cubit.dart';

class SearchMovieItem extends StatelessWidget {
  const SearchMovieItem({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final searchMovies = context.read<SearchCubit>().searchMoviesList;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(
              movie: movie,
              moreLikeMovies: searchMovies,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                ApiConstants.imageBaseUrl + movie.posterPath,
                width: 100.w,
                height: 150.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100.w,
                    height: 150.h,
                    color: AppColors.grayBackground,
                    child: Icon(
                      Icons.movie,
                      color: AppColors.grayColor,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    movie.date,
                    style: TextStyle(
                      color: AppColors.grayText,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 18.r,
                        color: AppColors.yellowColor,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        movie.rating.toStringAsFixed(1),
                        style: TextStyle(
                          color: AppColors.yellowColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
