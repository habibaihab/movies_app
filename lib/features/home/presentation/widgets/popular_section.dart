import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/web_service/api_constants.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';

import '../manager/popular_movies/get_movies_cubit.dart';
import '../pages/movie_details.dart';

class PopularSection extends StatelessWidget {
  const PopularSection({
    super.key,
    required this.movieEntity,
  });

  final MovieEntity movieEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      width: double.infinity,
      child: Stack(
        children: [

          SizedBox(
            width: double.infinity,
            height: 170.h,
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.gif",
              image: ApiConstants.imageBaseUrl + movieEntity.backdropPath,
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 55.h),
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppColors.textColor,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                    size: 40.r,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 12.w,
            top: 80.h,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    final popularMovies =
                        context.read<GetMoviesCubit>().popularMoviesList;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                          movie: movieEntity,
                          moreLikeMovies: popularMovies,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Image.network(
                      ApiConstants.imageBaseUrl + movieEntity.posterPath,
                      width: 130.w,
                      height: 180.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(5.r),
                  color: const Color(0xff514F4F),
                  child: Icon(
                    Icons.bookmark_add,
                    color: AppColors.textColor,
                    size: 28.r,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 155.w,
            right: 12.w,
            top: 185.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  movieEntity.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: AppColors.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  movieEntity.date,
                  style: TextStyle(
                    color: AppColors.grayText,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}