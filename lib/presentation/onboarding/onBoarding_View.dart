// ignore_for_file: unused_import, file_names, non_constant_identifier_names, unused_field, unused_element
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:providerlearn/app/dependacyinjection.dart';
import 'package:providerlearn/app/preferences.dart';
import 'package:providerlearn/domaine/models/Models.dart';
import 'package:providerlearn/presentation/onboarding/OnBoarding_ViewModel.dart';
import 'package:providerlearn/presentation/resources/ColorManager.dart';
import 'package:providerlearn/presentation/resources/ConstsManager.dart';
import 'package:providerlearn/presentation/resources/ImageManager.dart';
import 'package:providerlearn/presentation/resources/RoutesManager.dart';
import 'package:providerlearn/presentation/resources/StringManager.dart';
import 'package:providerlearn/presentation/resources/ValuesManager.dart';
import 'package:providerlearn/presentation/resources/ThemeManager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final OnBoardingViewModel _onBoardingViewModel = OnBoardingViewModel();

  _Bind() {
    _appPreferences.setOnBoardingScreenViewed();
    _onBoardingViewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _Bind();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _onBoardingViewModel.OutputSliderViewObject,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return getConetentWidget(snapshot.data);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget getConetentWidget(SliderViewObject? data) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: data?.numOfSlides,
        onPageChanged: (value) {
          _onBoardingViewModel.onPageChanged(value);
        },
        itemBuilder: (ctx, index) {
          return OnBoardingPage(data!.sliderObject);
        },
      ),
      bottomSheet: _getBottomSheetWidget(data!),
    );
  }

  Widget _getBottomSheetWidget(SliderViewObject data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p18),
          child: GestureDetector(
              onTap: () {
                _onBoardingViewModel.goBack();
              },
              child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(
                    ImageAssets.leftArrowIc,
                    color: ColorManager.primary,
                  ))),
        ),
        Row(
          children: [
            for (int i = 0; i < data.numOfSlides; i++)
              Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: _getProperCircle(i, data.currentIndex),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p18),
          child: GestureDetector(
              onTap: () {
                _onBoardingViewModel.goNext();
              },
              child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.rightArrowIc,
                      color: ColorManager.primary))),
        ),
      ],
    );
  }

  Widget _getProperCircle(int index, int currentValue) {
    Widget ReturnedWidget = currentValue == index
        ? SvgPicture.asset(
            color: ColorManager.primary, ImageAssets.hollowCircleIc)
        : SvgPicture.asset(
            color: ColorManager.primary, ImageAssets.solidCircleIc);
    return ReturnedWidget;
  }

  @override
  void dispose() {
    _onBoardingViewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _slider;
  const OnBoardingPage(
    this._slider, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: AppSize.s40,
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Text(_slider.HeadLine,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Text(_slider.Subline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge),
          ),
          const SizedBox(
            height: AppSize.s60,
          ),
          SvgPicture.asset(_slider.image),
        ],
      ),
      bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
