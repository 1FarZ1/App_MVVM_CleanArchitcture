// ignore_for_file: non_constant_identifier_names, unused_element
import 'dart:async';

import 'package:providerlearn/domaine/UseCase/LoginUseCase.dart';
import 'package:providerlearn/domaine/models/Models.dart';
import 'package:providerlearn/presentation/base/baseviewmodel.dart';
import 'package:providerlearn/presentation/common/freezed_data_classes.dart';


class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutPuts {
  final StreamController _userNamestreamController =
      StreamController<String>.broadcast();
  final StreamController _passWordstreamController =
      StreamController<String>.broadcast();
  final LoginObject _loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    // Perfomance Issues ~ U need to Stop The Controller after using it ~
    _userNamestreamController.close();
    _passWordstreamController.close();
  }

  @override
  void start() {
    // view model start khdma
  }

  //INPUTS
  @override
  Sink get InputPassword => _userNamestreamController.sink;

  @override
  Sink get InputUserName => _passWordstreamController.sink;

  @override
  login() async {
    (await _loginUseCase.excute(LoginUseCaseInput(
        email: _loginObject.userName, password: _loginObject.password)))
        .fold(
          (fail) => {
            fail.message
          }
        , (data) =>{
            data.customer
        } );
  }

  @override
  setPassword(String password) {
    InputPassword.add(password);
    _loginObject.copyWith(password: password);
  }

  @override
  setUsername(String uname) {
    InputUserName.add(uname);
    _loginObject.copyWith(userName: uname);
  }
  //OUTPUTS

  @override
  Stream<bool> get isPasswordValid => _passWordstreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get isUserNameValid => _userNamestreamController.stream
      .map((username) => _isUsernameValid(username));

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
}

abstract class LoginViewModelOutPuts {
  Stream<bool> get isUserNameValid;
  Stream<bool> get isPasswordValid;
}
