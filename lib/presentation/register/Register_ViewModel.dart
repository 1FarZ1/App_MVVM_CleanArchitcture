// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:async';
import 'dart:io';

import 'package:providerlearn/domaine/UseCase/RegisterUseCase.dart';
import 'package:providerlearn/presentation/base/baseviewmodel.dart';
import 'package:providerlearn/presentation/common/freezed_data_classes.dart';
import 'package:providerlearn/presentation/common/state_renderer/state_renderer.dart';
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
  final StreamController isUserLoggedInSuccefully = StreamController<bool>();

  RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  var registerObject = RegisterObject("userName", "countryMobileCode",
      "mobileNumber", "email", "password", "profilePicture");

  @override
  void start() {
    super.start();
    inputState.add(ContentState());
  }

  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _registerUseCase.excute(RegisterUseCaseInput(
            userName: registerObject.userName,
            countryMobileCode: registerObject.countryMobileCode,
            mobileNumber: registerObject.mobileNumber,
            email: registerObject.email,
            password: registerObject.password,
            profilePicture: registerObject.profilePicture)))
        .fold((fail) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, fail.message));
    }, (data) {
      inputState.add(SuccessState(AppStrings.register));
      isUserLoggedInSuccefully.add(true);
    });
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
    isUserLoggedInSuccefully.close();
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
  Sink get InputsAreAllValid => _AllValidStreamController.sink;

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
  Stream<File> get OutputsProfilePic =>
      _ProfilePicStreamController.stream.map((ProfilePic) {
        return ProfilePic;
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
  @override
  Stream<bool> get OutputsAreAllValid =>
      _AllValidStreamController.stream.map((_) {
        return _isAllValid();
      });

  bool _isMobileValid(String MobileNumber) {
    return MobileNumber.length == 10;
  }

  bool _isEmailValid(String Email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(Email);
  }

  _isProfilePicValid(File Profilepic) {
    return Profilepic.path.isNotEmpty;
  }

  bool _isUsernameValid(String Username) {
    return Username.length > 7;
  }

  bool _isPassValid(String Password) {
    return Password.length > 7 && Password.length < 20;
  }

  bool _isAllValid() {
    return registerObject.countryMobileCode.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
    ;
  }

  @override
  setCountryCode(String countryCode) {
    if ((countryCode.isNotEmpty)) {
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }

  @override
  setEmail(String Email) {
    InputEmail.add(Email);
    if (_isEmailValid(Email)) {
      registerObject = registerObject.copyWith(email: Email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String Mobilenumber) {
      InputsMobileNumber.add(Mobilenumber);
    if (_isMobileValid(Mobilenumber)) {
      registerObject = registerObject.copyWith(mobileNumber: Mobilenumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String Password) {
    InputsPass.add(Password);
    if (_isPassValid(Password)) {
      registerObject = registerObject.copyWith(password: Password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setUsername(String Username) {
    InputsUsername.add(Username);
    if (_isUsernameValid(Username)) {
      registerObject = registerObject.copyWith(userName: Username);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

  @override
  setProfilePic(File ProfilePic) {
    InputsProfilePic.add(ProfilePic);
    if (_isProfilePicValid(ProfilePic)) {
      registerObject = registerObject.copyWith(profilePicture: ProfilePic.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  validate() {
    InputsAreAllValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  Sink get InputEmail;
  Sink get InputsPass;
  Sink get InputsUsername;
  Sink get InputsMobileNumber;
  Sink get InputsProfilePic;
  Sink get InputsAreAllValid;

  //TODO: CHOF FORGET PASSWORD IDA DRT FUNCTIONS FE INPUT
  register();
  setUsername(String Username);
  setMobileNumber(String Mobilenumber);
  setEmail(String Email);
  setPassword(String Password);
  setProfilePic(File ProfilePic);
  setCountryCode(String countryCode);
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

  Stream<File> get OutputsProfilePic;
  Stream<bool> get OutputsAreAllValid;
}
