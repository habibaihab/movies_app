import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/route_manager/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),
    () {
      context.go(RouteNames.home);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(child: Center(child: Image.asset("assets/images/splashLogo.png",width: 300.w,))),
          Column(
            children: [
              Image.asset("assets/images/logo.png",width: 160.w,),
              Text("supervised by Mohamed Nabil",style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: AppColors.yellowColor
              ),),
              SizedBox(height: 18.h,)
            ],
          )
        ],

      ),
    );
  }
}
