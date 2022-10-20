// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:providerlearn/domaine/models/Models.dart';
import 'package:providerlearn/presentation/base/baseviewmodel.dart';
import 'package:providerlearn/presentation/resources/ImageManager.dart';
import 'package:providerlearn/presentation/resources/StringManager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _sliderDataList;
  int _currentPageindex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  // @override
  // ignore: todo
  // // TODO: implement inputState
  // Sink get inputState => throw UnimplementedError();

  @override
  void start() {
    // view model start khdma
    _sliderDataList = _getSliderData();
    _sendDataToView();
  }

  @override
  int goBack() {
    _currentPageindex = (_currentPageindex - 1 == -1)
        ? _sliderDataList.length
        : _currentPageindex - 1;
            _sendDataToView();
    return _currentPageindex;
  }

  @override
  int goNext() {
    _currentPageindex = (_currentPageindex + 1) == (_sliderDataList.length + 1)
        ? 0
        : _currentPageindex + 1;
            _sendDataToView();

    return _currentPageindex;
  }

  @override
  void onPageChanged(int index) {
    _currentPageindex = index;
    _sendDataToView();
    // ignore: todo
    // TODO: implement onPageChanged
  }

  @override
  // ignore: todo
  // TODO: implement InputSliderViewObject
  Sink get InputSliderViewObject => _streamController.sink;

  @override
  // ignore: todo
  // TODO: implement OutputSliderViewObject
  Stream<SliderViewObject> get OutputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) {
        return sliderViewObject;
      });

// data to Display
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4)
      ];
  // onboarding private functions
  SliderViewObject _sendDataToView() {
    InputSliderViewObject.add(SliderViewObject(
        _sliderDataList[_currentPageindex],
        _sliderDataList.length,
        _currentPageindex));

    //test perpose
    return SliderViewObject(_sliderDataList[_currentPageindex],
        _sliderDataList.length, _currentPageindex);
  }
}

abstract class OnBoardingViewModelInputs {
  int goNext();
  int goBack();
  void onPageChanged(int index);

  Sink get InputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get OutputSliderViewObject;
}
