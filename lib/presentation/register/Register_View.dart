// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:providerlearn/app/dependacyinjection.dart';
import 'package:providerlearn/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:providerlearn/presentation/register/Register_ViewModel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
 final TextEditingController _UsernametextEditingController =
      TextEditingController();
 final TextEditingController _PasswordtextEditingController =
      TextEditingController();
 final TextEditingController _MobileNumbertextEditingController =
      TextEditingController();
 final TextEditingController _CountryCodetextEditingController =
      TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();

  _bind() {
    _registerViewModel.start();
    _UsernametextEditingController.addListener(() =>
        _registerViewModel.setUsername(_UsernametextEditingController
            .text));
    _PasswordtextEditingController.addListener(()=>
        _registerViewModel.setPassword(_PasswordtextEditingController.text));
    _MobileNumbertextEditingController.addListener(()=>_registerViewModel.setMobileNumber(_MobileNumbertextEditingController.text));
    _CountryCodetextEditingController.addListener(()=>_registerViewModel.setCountryCode(_CountryCodetextEditingController.text));
  }
  @override
  void initState() {
    _bind();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _registerViewModel.outputState,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
        return snapshot.data?.getScreenWidget(
              context: context,
              contentScreenWidget: _getContentWidget(),
              retryActionFunction: () {
                _registerViewModel.register();
              },
            ) ??
            _getContentWidget();
       },

    );
  }

  _getContentWidget(){
    
  }
  @override
  void dispose() {
    
    super.dispose();
    _registerViewModel.dispose();
  }
}
