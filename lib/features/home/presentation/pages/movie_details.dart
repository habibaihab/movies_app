import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';

import '../../../../core/web_service/api_constants.dart';
import '../../../watch_list/presentation/widgets/watch_list_bookmark.dart';
import '../widgets/movie_widgets/more_like_this.dart';
import '../widgets/movie_widgets/movies_title.dart';

class MovieDetails extends StatelessWidget {
  final MovieEntity movie;
  final List<MovieEntity> moreLikeMovies;
  const MovieDetails({super.key, required this.movie, required this.moreLikeMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.grayBackground,
        iconTheme: IconThemeData(color: Colors.white, size: 30.sp),
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 217.h,
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: ApiConstants.imageBaseUrl + movie.backdropPath,
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
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                spacing: 5.r,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  Text(
                    movie.date,
                    style: TextStyle(color: AppColors.grayText, fontSize: 14.sp),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              ApiConstants.imageBaseUrl + movie.posterPath,
                              width: 130.w,
                              height: 210.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            child: WatchListBookmark(movie: movie),
                          ),
                        ],
                      ),
        
                      SizedBox(width: 15.w),
        
                      Expanded(
                        child: Column(
                          spacing:15.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: List.generate(
                                5,
                                (index) => Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundColor,
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(
                                      color: AppColors.grayText,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'Action',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
        
                            Text(
                              movie.overView,maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
        
                              ),
                            ),
                            Row(
                              spacing: 5.r,
                              children: [
                                Icon(Icons.star , size: 24.r,color: AppColors.yellowColor,),
                                Text(movie.rating.toString(),style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
                horizontal: 10.w,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grayBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 18.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MoviesTitle(moviesType: "More Like This"),
        
                  SizedBox(
                    height: 250.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
        
        
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 20.w);
                      },
        
                      itemCount: moreLikeMovies.length,
                      itemBuilder: (context, index) {
                        return MoreLikeThis(
                          movie: moreLikeMovies[index],
                        );
                      },
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
