import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/web_service/api_constants.dart';
import 'package:movies_app/features/browse/presentation/manager/movies_by_genre_id/get_movies_by_genre_id_cubit.dart';

import '../../../home/presentation/pages/movie_details.dart';

class GenreMoviesScreen extends StatelessWidget {
  final int genreId;

  const GenreMoviesScreen({
    super.key,
    required this.genreId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.grayBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28.sp,
          ),
        ),
        title: Text(
          'Movies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<GetMoviesByGenreIdCubit, GetMoviesByGenreIdState>(
        builder: (context, state) {
          if (state is GetMoviesByGenreIdLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetMoviesByGenreIdFailed) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          if (state is GetMoviesByGenreIdEmpty) {
            return const Center(
              child: Text(
                'No Movies Found',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          if (state is GetMoviesByGenreIdSuccess) {
            final movies = context.read<GetMoviesByGenreIdCubit>().moviesList;

            return GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.65,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                          movie: movie,
                          moreLikeMovies: movies,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}