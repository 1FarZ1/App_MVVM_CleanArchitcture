// ignore_for_file: non_constant_identifier_names, unused_element
import 'dart:async';

import 'package:providerlearn/presentation/base/baseviewmodel.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutPuts {
  final StreamController _userNamestreamController =
      StreamController<String>.broadcast();
  final StreamController _passWordstreamController =
      StreamController<String>.broadcast();

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
  login() {
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    throw UnimplementedError();
  }

  @override
  setUsername(String uname) {
    throw UnimplementedError();
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
