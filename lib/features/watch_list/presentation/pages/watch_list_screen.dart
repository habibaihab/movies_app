import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/features/watch_list/presentation/manager/watch_list/watch_list_cubit.dart';
import 'package:movies_app/features/watch_list/presentation/widgets/watch_list_movie_item.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<WatchListCubit, WatchListState>(
          builder: (context, state) {
            if (state is WatchListLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellowColor,
                ),
              );
            } else if (state is WatchListSuccess) {
              return ListView.separated(
                itemCount: context.read<WatchListCubit>().watchListMovies.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: AppColors.grayBackground,
                    indent: 16.w,
                    endIndent: 16.w,
                  );
                },
                itemBuilder: (context, index) {
                  return WatchListMovieItem(
                    movie: context.read<WatchListCubit>().watchListMovies[index],
                  );
                },
              );
            } else if (state is WatchListEmpty) {
              return Center(
                child: Text(
                  "No movies in Watch List",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16.sp,
                  ),
                ),
              );
            } else if (state is WatchListError) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
