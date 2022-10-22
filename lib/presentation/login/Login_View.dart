// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:providerlearn/presentation/login/Login_ViewModel.dart';
import 'package:providerlearn/presentation/resources/ColorManager.dart';
import 'package:providerlearn/presentation/resources/ImageManager.dart';
import 'package:providerlearn/presentation/resources/StringManager.dart';
import 'package:providerlearn/presentation/resources/ValuesManager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = LoginViewModel();
  final TextEditingController _UsernametextEditingController =
      TextEditingController();
  final TextEditingController _PasswordtextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _bind() {
    _loginViewModel.start();
    _UsernametextEditingController.addListener(() =>
        _loginViewModel.setUsername(_UsernametextEditingController
            .text)); // dirna listener l username we password editing controller
    _PasswordtextEditingController.addListener(() =>
        _loginViewModel.setPassword(_PasswordtextEditingController
            .text)); // bch kol ma ytbdl text fihom nbdl uname we pass fe view model
    // tell loginviewmodel to start the job ;
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    super.dispose();
    _loginViewModel.dispose();
    _UsernametextEditingController.dispose();
    _PasswordtextEditingController.dispose();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p50),
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: Image.asset(
                      ImageAssets.astroNout,
                    )),
              ),
              const SizedBox(
                height: AppSize.s60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _loginViewModel.outisUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _UsernametextEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _loginViewModel.outisPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _PasswordtextEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _loginViewModel.outisInputsValid,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                          onPressed: (snapshot.data == true)
                              ? () async {
                                  await _loginViewModel.login();
                                }
                              : null,
                          child: Text(
                            AppStrings.login,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ));
                    }),
              ),
            ],
          ),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }
}
