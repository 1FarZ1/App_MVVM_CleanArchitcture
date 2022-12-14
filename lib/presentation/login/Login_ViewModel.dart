// ignore_for_file: non_constant_identifier_names, unused_element
import 'dart:async';

import 'package:providerlearn/data/Network/failure.dart';
import 'package:providerlearn/domaine/UseCase/LoginUseCase.dart';
import 'package:providerlearn/domaine/models/Models.dart';
import 'package:providerlearn/presentation/base/baseviewmodel.dart';
import 'package:providerlearn/presentation/common/freezed_data_classes.dart';
import 'package:providerlearn/presentation/common/state_renderer/state_renderer.dart';
import 'package:providerlearn/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutPuts {
  final StreamController _userNamestreamController =
      BehaviorSubject<String>();
  final StreamController _passWordstreamController =
      BehaviorSubject<String>();
  final StreamController _isLoginValidstreamController =
      BehaviorSubject<void>();
  final StreamController isUserLoggedInSuccefully = StreamController<bool>();
  LoginObject _loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);
  @override
  void dispose() {
    super.dispose();
    // Perfomance Issues ~ U need to Stop The Controller after using it ~
    _userNamestreamController.close();
    _passWordstreamController.close();
    _isLoginValidstreamController.close();
    isUserLoggedInSuccefully.close();
  }

  @override
  void start() {
    // view model start khdma
    inputState.add(ContentState());
  }

  // -------------------------------------------------------------------
  //INPUTS
  @override
  Sink get InputUserName => _userNamestreamController.sink;

  @override
  Sink get InputPassword => _passWordstreamController.sink;

  @override
  Sink get isInputsValid => _isLoginValidstreamController.sink;

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _loginUseCase.excute(LoginUseCaseInput(
            email: _loginObject.userName, password: _loginObject.password)))
        .fold(
            (fail) => {
                  inputState.add(ErrorState(
                      StateRendererType.popupErrorState, fail.message))
                }, (data) {
      inputState.add(SuccessState("Login Success"));
      isUserLoggedInSuccefully.add(true);
      });
  }

  @override
  setPassword(String password) {
    InputPassword.add(password);

    // 1 h of looking for solution  old version [_loginObject.copyWith(password: password);]
    _loginObject = _loginObject.copyWith(password: password);
    isInputsValid.add(null); // we pass null because we dont need the value
    // passed in the stream all we need is
    //the password and email passed in the other
    //streams to check it in the stream if its valid and he can login
  }

  @override
  setUsername(String uname) {
    InputUserName.add(uname);
    _loginObject = _loginObject.copyWith(userName: uname);
    isInputsValid.add(null);
  }

  // -------------------------------------------------------------------
  //OUTPUTS

  @override
  Stream<bool> get outisPasswordValid => _passWordstreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outisUserNameValid => _userNamestreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<bool> get outisInputsValid =>
      _isLoginValidstreamController.stream.map((_) => _IsValid());

  // -------------------------------------------------------------------
  // -------------------------------------------------------------------
  // -------------------------------------------------------------------

  bool _IsValid() {
    // print(
    //     "The Username is ${_loginObject.userName} ~~ The Password is ${_loginObject.password}");
    // }
    return _isPasswordValid(_loginObject.password) &&
        _isUsernameValid(_loginObject.userName);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  setUsername(String uname);
  setPassword(String password);
  login();

  Sink get InputUserName;
  Sink get InputPassword;
  Sink get isInputsValid;
}

abstract class LoginViewModelOutPuts {
  Stream<bool> get outisUserNameValid;
  Stream<bool> get outisPasswordValid;
  Stream<bool> get outisInputsValid;
}
