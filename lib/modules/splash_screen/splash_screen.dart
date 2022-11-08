import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_movie_app/layout/movie_layout.dart';

import '../../shared/components/constants.dart';
import '../../shared/style/asset_manager.dart';
import '../../shared/style/color_manager.dart';
import '../on_boarding_screen/on_boarding_screen.dart';


class SplashScreen extends  StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   var _timer;
   _startDelay(){
    _timer = Timer( const Duration(seconds: 5), _goNext);
  }
  _goNext(){
    if(uId == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const OnBoardingScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MovieLayout()));
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Lottie.asset(AssetsManager.splashScreen)),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _timer!.cancel();
    super.dispose();
  }
}
