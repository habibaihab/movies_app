import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/app_colors.dart';

class MoviesTitle extends StatelessWidget {
  const MoviesTitle({super.key, required this.moviesType});

  final String moviesType;

  @override
  Widget build(BuildContext context) {
    return Text(
      moviesType,style: GoogleFonts.inter(
        color: AppColors.textColor,
        fontSize: 18.sp
    ),
    );
  }
}
