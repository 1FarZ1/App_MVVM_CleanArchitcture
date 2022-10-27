// ignore_for_file: file_names

import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:providerlearn/app/consts.dart';
import 'package:providerlearn/app/dependacyinjection.dart';
import 'package:providerlearn/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:providerlearn/presentation/register/Register_ViewModel.dart';
import 'package:providerlearn/presentation/resources/ColorManager.dart';
import 'package:providerlearn/presentation/resources/ImageManager.dart';
import 'package:providerlearn/presentation/resources/RoutesManager.dart';
import 'package:providerlearn/presentation/resources/StringManager.dart';
import 'package:providerlearn/presentation/resources/ValuesManager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final TextEditingController _UsernametextEditingController =
      TextEditingController();
  final TextEditingController _PasswordtextEditingController =
      TextEditingController();
  final TextEditingController _MobileNumbertextEditingController =
      TextEditingController();
  final TextEditingController _EmailtextEditingController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();

  _bind() {
    _registerViewModel.start();
    _UsernametextEditingController.addListener(() =>
        _registerViewModel.setUsername(_UsernametextEditingController.text));
    _PasswordtextEditingController.addListener(() =>
        _registerViewModel.setPassword(_PasswordtextEditingController.text));
    _MobileNumbertextEditingController.addListener(() => _registerViewModel
        .setMobileNumber(_MobileNumbertextEditingController.text));
    _EmailtextEditingController.addListener(() =>
        _registerViewModel.setCountryCode(_EmailtextEditingController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _registerViewModel.outputState,
        builder: (BuildContext context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context: context,
                contentScreenWidget: _getContentWidget(),
                retryActionFunction: () {
                  // en sait jamais yji error y3awd ydir call ll api  m3a error pop up
                  _registerViewModel.register();
                },
              ) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.p100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    ImageAssets.astroNout,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p50),
                child: StreamBuilder<String?>(
                    stream: _registerViewModel.OutputsErrorUsername,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _UsernametextEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            errorText: snapshot.data),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s14,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p50),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CountryCodePicker(
                          onChanged: (country) {
                            _registerViewModel.setCountryCode(
                                country.code ?? Constants.Token);
                          },
                          initialSelection: '+02',
                          favorite: const ['+39', 'FR', "+966"],
                          showCountryOnly: true,
                          hideMainText: true,
                          showOnlyCountryWhenClosed: true,
                        ),
                      ),
                      StreamBuilder<String?>(
                          stream: _registerViewModel.OutputsErrorMobileNumber,
                          builder: (context, snapshot) {
                            return Expanded(
                              flex: 4,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _MobileNumbertextEditingController,
                                decoration: InputDecoration(
                                  hintText: AppStrings.mobileNumber,
                                  labelText: AppStrings.mobileNumber,
                                  errorText: snapshot.data,
                                ),
                              ),
                            );
                          }),
                    ],
                  )),
              const SizedBox(
                height: AppSize.s14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p50),
                child: StreamBuilder<String?>(
                    stream: _registerViewModel.OutputsErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _EmailtextEditingController,
                        decoration: InputDecoration(
                          hintText: AppStrings.emailHint,
                          labelText: AppStrings.emailHint,
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p50),
                child: StreamBuilder<String?>(
                    stream: _registerViewModel.OutputsErrorPass,
                    builder: (context, snapshot) {
                      return TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _PasswordtextEditingController,
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password,
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s14,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p50),
                  child: Container(
                    height: AppSize.s50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorManager.grey,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.circular(AppSize.s14),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: _getMediaWidget(),
                    ),
                  )),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _registerViewModel.OutputsAreAllValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: AppSize.s220,
                        height: AppSize.s50,
                        child: ElevatedButton(
                            onPressed: (snapshot.data == true)
                                ? () async {
                                    await _registerViewModel.register();
                                  }
                                : null,
                            child: Text(
                              AppStrings.register,
                              style: Theme.of(context).textTheme.displayLarge,
                            )),
                      );
                    }),
              ),
              AlreadyHaveAccountTextButton(context: context),
            ],
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _registerViewModel.dispose();
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 2,
              child: Text(
                AppStrings.profilePicture,
                style: Theme.of(context).textTheme.bodyLarge,
              )),
          Flexible(
              child: StreamBuilder<File>(
            stream: _registerViewModel.OutputsProfilePic,
            builder: (context, snapshot) {
              return _imagepicked(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc))
        ],
      ),
    );
  }

  //TODO:ADD cahr7 l had function :
  Widget _imagepicked(File? fileImage) {
    if (fileImage != null && fileImage.path.isNotEmpty) {
      return Image.file(fileImage);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(direction: Axis.vertical, children: [
              ListTile(
                leading: const Icon(Icons.browse_gallery),
                trailing: const Icon(Icons.arrow_forward),
                title: const Text(AppStrings.photoGallery),
                onTap: () {
                  _pickImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                trailing: const Icon(Icons.arrow_forward),
                title: const Text(AppStrings.photoCamera),
                onTap: () {
                  _pickImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ]),
          );
        });
  }

  void _pickImageFromGallery() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _registerViewModel.setProfilePic(File(image?.path ?? " "));
  }

  void _pickImageFromCamera() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    _registerViewModel.setProfilePic(File(image?.path ?? ""));
  }
}

class AlreadyHaveAccountTextButton extends StatelessWidget {
  const AlreadyHaveAccountTextButton({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p8, left: AppPadding.p28, right: AppPadding.p28),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(AppStrings.alreadyHaveAccount,
            style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
