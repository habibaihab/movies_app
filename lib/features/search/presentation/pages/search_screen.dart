import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/features/search/presentation/manager/search_movies/search_cubit.dart';
import 'package:movies_app/features/search/presentation/widgets/search_movie_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: TextField(
                controller: searchController,
                style: TextStyle(color: AppColors.textColor, fontSize: 16.sp),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  context.read<SearchCubit>().getSearchMovies(value);
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: AppColors.grayText),
                  prefixIcon: Icon(Icons.search, color: AppColors.grayColor),
                  filled: true,
                  fillColor: AppColors.grayBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.yellowColor,
                      ),
                    );
                  } else if (state is SearchSuccess) {
                    return ListView.separated(
                      itemCount:
                          context.read<SearchCubit>().searchMoviesList.length,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: AppColors.grayBackground,
                          indent: 16.w,
                          endIndent: 16.w,
                        );
                      },
                      itemBuilder: (context, index) {
                        return SearchMovieItem(
                          movie: context
                              .read<SearchCubit>()
                              .searchMoviesList[index],
                        );
                      },
                    );
                  } else if (state is SearchEmpty) {
                    return Center(
                      child: Text(
                        "No movies found",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    );
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      "Search for a movie",
                      style: TextStyle(
                        color: AppColors.grayText,
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
