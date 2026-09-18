import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/features/home/presentation/manager/new_releases_movies/new_releases_cubit.dart';
import 'package:movies_app/features/home/presentation/manager/popular_movies/get_movies_cubit.dart';
import 'package:movies_app/features/home/presentation/manager/up_coming_movies/up_coming_cubit.dart';
import 'package:movies_app/features/home/presentation/widgets/movie_widgets/movies_title.dart';
import 'package:movies_app/features/home/presentation/widgets/popular_section.dart';
import 'package:movies_app/features/home/presentation/widgets/recommended_section.dart';
import 'package:movies_app/features/home/presentation/widgets/release_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetMoviesCubit,GetMoviesState>(
                builder: (context, state) {
                  if(state is LoadingGetMovies) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(state is SuccessGetMovies) {
                    return Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: context.read<GetMoviesCubit>().popularMoviesList.length,
                          itemBuilder: (context, index, realIndex) {
                            return PopularSection(movieEntity: context.read<GetMoviesCubit>().popularMoviesList[index],);
                          },
                          options: CarouselOptions(
                            height: 300.h,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            autoPlayInterval: Duration(seconds: 4),
                          ),
                        )
                      ],
          
                    );
                  }
                  else if(state is ErrorGetMovies){
                    return Center(
                      child: Text(state.errorMessage , style:TextStyle(
                          color: Colors.white
                      ),),
                    );
                  }
                  return SizedBox();
                },),
              BlocBuilder<NewReleasesCubit,NewReleasesState>(
                builder: (context, state) {
                  if(state is SuccessNewReleasesMovies){
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 20.h , horizontal: 10.w),
                      width: double.infinity,
                      // height: 250.h,
                      decoration: BoxDecoration(
                        color: AppColors.grayBackground
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 18.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MoviesTitle(moviesType: "New Releases"),
                          SizedBox(
                            height: 160.h,
                            child: ListView.separated(
                              itemCount: context.read<NewReleasesCubit>()
                                  .newReleasesMoviesList.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 20.w,
                                );
                              },
                              itemBuilder: (context, index) {
                                return ReleaseSection(movieEntity: context.read<NewReleasesCubit>()
                                    .newReleasesMoviesList[index],);
                              },
                            ),
                          ),
                        ],
                      )
                    );
                  }
                  return SizedBox();
                },),
              SizedBox(height: 15.h,),
              BlocBuilder<UpComingCubit,UpComingState>(builder: (context, state) {
                if(state is UpComingLoading){
                  return Center(child: CircularProgressIndicator(),);
                } else if(state is UpComingSuccess){
                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 10.w,
                    ),
                    width: double.infinity,
                    // height: 320.h,
                    decoration: BoxDecoration(
                      color: AppColors.grayBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 18.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MoviesTitle(moviesType: "Recommended"),
                        SizedBox(
                          height: 250.h,
                          child: ListView.separated(
                            itemCount: context
                                .read<UpComingCubit>()
                                .upComingMovies
                                .length,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 20.w);
                            },
                            itemBuilder: (context, index) {
                              return RecommendedSection(
                                movie: context
                                    .read<UpComingCubit>()
                                    .upComingMovies[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );                }
                return SizedBox();
              },),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      )
    );
  }
}
