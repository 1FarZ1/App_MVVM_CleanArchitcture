// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:async';
import 'dart:io';

import 'package:providerlearn/domaine/UseCase/RegisterUseCase.dart';
import 'package:providerlearn/presentation/base/baseviewmodel.dart';
import 'package:providerlearn/presentation/common/freezed_data_classes.dart';
import 'package:providerlearn/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:providerlearn/presentation/resources/StringManager.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController _AllValidStreamController =
      StreamController<void>.broadcast();
  final StreamController _EmailStreamController =
      StreamController<String>.broadcast();
  final StreamController _PassStreamController =
      StreamController<String>.broadcast();
  final StreamController _MobileStreamController =
      StreamController<String>.broadcast();
  final StreamController _UsernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _ProfilePicStreamController =
      StreamController<File>.broadcast();

  RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  var registerObject = RegisterObject("userName", "countryMobileCode",
      "mobileNumber", "email", "password", "profilePicture");
  
  @override
  void start() {
    super.start();
  }


  @override
  void dispose() {
    super.dispose();

    _EmailStreamController.close();
    _PassStreamController.close();
    _MobileStreamController.close();
    _UsernameStreamController.close();
    _AllValidStreamController.close();
    _ProfilePicStreamController.close();
  }

  @override
  Sink get InputEmail => _EmailStreamController.sink;

  @override
  Sink get InputsMobileNumber => _MobileStreamController.sink;

  @override
  Sink get InputsPass => _PassStreamController.sink;

  @override
  Sink get InputsUsername => _UsernameStreamController.sink;

  @override
  Sink get InputsProfilePic => _ProfilePicStreamController.sink;

  @override
  Stream<bool> get OutPutsMobileNumber =>
      _MobileStreamController.stream.map((MobileNumber) {
        return _isMobileValid(MobileNumber);
      });

  @override
  Stream<bool> get OutputEmail => _EmailStreamController.stream.map((Email) {
        return _isEmailValid(Email);
      });

  @override
  Stream<bool> get OutputPass => _PassStreamController.stream.map((Pass) {
        return _isPassValid(Pass);
      });

  @override
  Stream<bool> get OutputsUsername =>
      _UsernameStreamController.stream.map((Username) {
        return _isUsernameValid(Username);
      });
  @override
  Stream<bool> get OutputsProfilePic =>
      _ProfilePicStreamController.stream.map((ProfilePic) {
        return _isProfilePicValid(ProfilePic);
      });

  @override
  Stream<String?> get OutputsErrorEmail => OutputEmail.map(
      (isEmailValid) => isEmailValid ? null : AppStrings.invalidEmail);

  @override
  Stream<String?> get OutputsErrorMobileNumber => OutPutsMobileNumber.map(
      (isMobileValid) => isMobileValid ? null : AppStrings.mobileNumberInvalid);

  @override
  Stream<String?> get OutputsErrorPass => OutputPass.map(
      (isPassValid) => isPassValid ? null : AppStrings.passwordInvalid);

  @override
  Stream<String?> get OutputsErrorUsername => OutputsUsername.map(
      (isUsernameValid) => isUsernameValid ? null : AppStrings.userNameInvalid);

  bool _isMobileValid(String MobileNumber) {
    return MobileNumber.length == 10;
  }

  bool _isEmailValid(String Email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(Email);
  }

  _isProfilePicValid(File Profilepic) {}

  bool _isUsernameValid(String Username) {
    return Username.length > 7;
  }

  bool _isPassValid(String Password) {
    return Password.length > 7 && Password.length < 20;
  }
}

abstract class RegisterViewModelInputs {
  Sink get InputEmail;
  Sink get InputsPass;
  Sink get InputsUsername;
  Sink get InputsMobileNumber;
  Sink get InputsProfilePic;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get OutputEmail;
  Stream<String?> get OutputsErrorEmail;
  Stream<bool> get OutputPass;
  Stream<String?> get OutputsErrorPass;

  Stream<bool> get OutPutsMobileNumber;
  Stream<String?> get OutputsErrorMobileNumber;

  Stream<bool> get OutputsUsername;
  Stream<String?> get OutputsErrorUsername;

  Stream<bool> get OutputsProfilePic;
}
