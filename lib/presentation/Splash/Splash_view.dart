// ignore_for_file: unused_field, file_names

import 'dart:async';

import 'package:flutter/material.dart';
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

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay),
        () => Navigator.pushReplacementNamed(context, Routes.onBoardingRoute));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image.asset(ImageAssets.splashLogo)),
    );
  }
}
