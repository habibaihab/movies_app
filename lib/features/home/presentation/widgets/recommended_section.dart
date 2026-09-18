import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/home/presentation/manager/up_coming_movies/up_coming_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/web_service/api_constants.dart';
import '../pages/movie_details.dart';

class RecommendedSection extends StatelessWidget {

  final MovieEntity movie;
  const RecommendedSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      child: Card(
        color: AppColors.grayBackground,
        elevation: 6,
        clipBehavior: Clip.none,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // spacing: 10,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: () {
                    final recommendedMovies = context.read<UpComingCubit>().upComingMovies;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>  MovieDetails(movie: movie,moreLikeMovies:recommendedMovies,
                      ),),);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      ApiConstants.imageBaseUrl + movie.posterPath,
                      width: 150.w,
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                    top: 0,
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
            ),
            Container(
              padding: EdgeInsets.all(8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.r,
                children: [
                  Row(
                    spacing: 5.r,
                    children: [
                      Icon(Icons.star , size: 20.r,color: AppColors.yellowColor,),
                      Text(movie.rating.toString(),style: TextStyle(
                          color: AppColors.yellowColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                  Text(movie.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1
                    , style: TextStyle(
                    color: AppColors.textColor,
                      fontSize: 12.sp
                  ),),
                  Text(movie.date,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1
                    , style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 12.sp
                    ),)
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
