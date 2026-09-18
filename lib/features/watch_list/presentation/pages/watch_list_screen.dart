import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Text(
            'Watch List',
            style: TextStyle(color: AppColors.textColor),
          ),
        ),
      ),
    );
  }
}
