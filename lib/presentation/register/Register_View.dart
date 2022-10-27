// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:providerlearn/app/dependacyinjection.dart';
import 'package:providerlearn/presentation/register/Register_ViewModel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();

  _bind() {
    _registerViewModel.start();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _registerViewModel.dispose();
  }
}
