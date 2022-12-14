import 'dart:async';
import 'dart:ffi';

import 'package:providerlearn/domaine/UseCase/StoreDetaillsUseCase.dart';
import 'package:providerlearn/domaine/models/Models.dart';
import 'package:providerlearn/presentation/base/baseviewmodel.dart';
import 'package:providerlearn/presentation/common/state_renderer/state_renderer.dart';
import 'package:providerlearn/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/subjects.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final StreamController _dataStreamController =
      BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase _useCase;
  StoreDetailsViewModel(this._useCase);

  @override
  void start() {
    super.start();
    _getHomeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _dataStreamController.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails => _dataStreamController.stream.map((data) => 
  data);

  _getHomeData() async {
    inputState.add(StateRendererType.fullScreenLoadingState);
    (await _useCase.excute(Void)).fold(
        (failure) => inputState.add(
            ErrorState(StateRendererType.popupErrorState, failure.message)),
        (data) async{
      inputState.add(ContentState());
      inputStoreDetails.add(data);
    });
  }
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
