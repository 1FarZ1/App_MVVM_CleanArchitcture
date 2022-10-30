// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:providerlearn/domaine/UseCase/forgetPasswordUseCase.dart';
import 'package:providerlearn/presentation/base/baseviewmodel.dart';
import 'package:providerlearn/presentation/common/state_renderer/state_renderer.dart';
import 'package:providerlearn/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _IsAllInputValidStreamController =
      BehaviorSubject<String>();
  final StreamController _IsEmailValidStreamController =
      BehaviorSubject<String>();

  @override
  void dispose() {
    _IsAllInputValidStreamController.close();
    _IsEmailValidStreamController.close();
  }

  ForgotPasswordViewModel(this._forgetPasswordUseCase);
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  var email = "";

  @override
  void start() {
    inputState.add(ContentState());
  }

  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgetPasswordUseCase.excute(email)).fold(
        (fail) => inputState
            .add(ErrorState(StateRendererType.popupErrorState, fail.message)),
        (data) {
      return inputState.add(SuccessState(data));
    });
  }

  setEmail(String text) {
    inputIsEmailValid.add(email);
    email = text;
    _validate();
  }

  @override
  Sink get inputIsAllInputValid => _IsAllInputValidStreamController.sink;

  @override
  Sink get inputIsEmailValid => _IsEmailValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputValid =>
      _IsAllInputValidStreamController.stream.map((Input) {
        return _isallInputsValid();
      });

  @override
  Stream<bool> get outputIsEmailValid =>
      _IsEmailValidStreamController.stream.map((Email) => _isEmailValid(Email));

  bool _isEmailValid(Email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(Email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }

  _isallInputsValid() {
    return _isEmailValid(email);
  }
}

abstract class ForgotPasswordViewModelInputs {
  void start(); // start view model job ( N3ytolo ki ybda view model lkhdma)

  void
      dispose(); // will be called when view model dies ( N3ytolo ki ykml  view model lkhdma)

  Sink get inputIsEmailValid;
  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputValid;
}
