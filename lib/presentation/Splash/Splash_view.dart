// ignore_for_file: unused_field, file_names, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:providerlearn/app/dependacyinjection.dart';
import 'package:providerlearn/app/preferences.dart';
import 'package:providerlearn/presentation/resources/ColorManager.dart';
import 'package:providerlearn/presentation/resources/ConstsManager.dart';
import 'package:providerlearn/presentation/resources/ImageManager.dart';
import 'package:providerlearn/presentation/resources/RoutesManager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences= instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), () {
      _appPreferences.IsLoggedIn().then((IsUserLoggedIn) =>
      { 

        if(IsUserLoggedIn == true ){
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute)
        }
        else{
          _appPreferences.OnBoardingScreenViewed().then((BoardingViewed) => {
            if(BoardingViewed ==true){
              Navigator.pushReplacementNamed(context, Routes.loginRoute)
            }
            else{
              Navigator.pushReplacementNamed(context, Routes.onBoardingRoute)
            }
          })

        }
      } 
      );
    
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // to cache images and other stuff before the user see the app
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(ImageAssets.splashLogo), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image.asset(ImageAssets.splashLogo)),
    );
  }
}
