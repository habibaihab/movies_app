import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/web_service/api_constants.dart';
import '../../../domain/entities/movie_entity.dart';

class MoreLikeThis extends StatelessWidget {
  final MovieEntity movie;

  const MoreLikeThis({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      child: Card(
        elevation: 6,
        color: AppColors.grayBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                ApiConstants.imageBaseUrl + movie.posterPath,
                width: 150.w,
                height: 150.h,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 20.r,
                        color: AppColors.yellowColor,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        movie.rating.toString(),
                        style: TextStyle(
                          color: AppColors.yellowColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 12.sp,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Text(
                    movie.date,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 12.sp,
                    ),
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