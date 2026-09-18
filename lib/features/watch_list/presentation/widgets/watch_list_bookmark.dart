import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/watch_list/presentation/manager/watch_list/watch_list_cubit.dart';

class WatchListBookmark extends StatelessWidget {
  const WatchListBookmark({
    super.key,
    required this.movie,
    this.iconSize = 30,
  });

  final MovieEntity movie;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchListCubit, WatchListState>(
      builder: (context, state) {
        final isSaved = context.read<WatchListCubit>().isInWatchList(movie.id);
        return GestureDetector(
          onTap: () {
            context.read<WatchListCubit>().toggleWatchList(movie);
          },
          child: Container(
            padding: EdgeInsets.all(5.r),
            color: const Color(0xff514F4F),
            child: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_add,
              size: iconSize,
              color: isSaved ? AppColors.yellowColor : AppColors.textColor,
            ),
          ),
        );
      },
    );
  }
}
