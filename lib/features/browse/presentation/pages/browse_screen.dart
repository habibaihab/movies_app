import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/features/browse/presentation/manager/genres_movies/genres_movies_cubit.dart';
import 'package:movies_app/features/browse/presentation/manager/movies_by_genre_id/get_movies_by_genre_id_cubit.dart';
import 'package:movies_app/features/browse/presentation/pages/genre_movies_screen.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        backgroundColor: AppColors.grayBackground,
        elevation: 0,
        title: Text(
          'Browse',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Explore by Genre',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16.h),

            Expanded(
              child: BlocBuilder<GenresMoviesCubit,GenresMoviesState>(
                  builder: (context, state){
                    if(state is GenresMoviesLoading){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }else if (state is GenresMoviesFailed){
                      return Center(
                        child: Text(
                          state.errorMessage,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else if(state is GenresMoviesEmpty){
                      return const Center(
                        child: Text(
                          'No Genres Found',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    } if(state is GenresMoviesSuccess){

                      final genres = context.read<GenresMoviesCubit>().genresMoviesList;
                      return GridView.builder(
                        itemCount: genres.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 1.7,
                        ),
                        itemBuilder: (context, index) {
                          final genre = genres[index];
                          return GestureDetector(
                            onTap: () {
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (context) => BlocProvider(
                                     create: (context) => GetMoviesByGenreIdCubit()
                                       ..getMoviesByGenreId(genre.id),
                                 child: GenreMoviesScreen(genreId: genre.id,),),));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.grayBackground,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.08),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [

                                    Expanded(
                                      child: Text(
                                        genre.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white54,
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },)
            ),
          ],
        ),
      ),
    );
  }
}