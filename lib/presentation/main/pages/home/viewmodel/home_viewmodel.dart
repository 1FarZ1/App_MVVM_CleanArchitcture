import 'dart:async';
import 'dart:ffi';

import 'package:providerlearn/domaine/Models/Models.dart';
import 'package:providerlearn/domaine/UseCase/home_usecase.dart';
import 'package:providerlearn/presentation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final _dataStreamController =
      StreamController<String>(); // BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  // --  inputs
  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.excute(Void)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, failure.message))
            }, (homeObject) {
      // right -> data (success)
      // content
      inputState.add(ContentState());
      inputHomeData.add("test");
      // navigate to main screen

      // HomeViewObject(homeObject.homeData.stores, homeObject.homeData.services,
      //     homeObject.homeData.banners);
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // -- outputs
  @override
  Stream<String> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<String> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<Banner> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
