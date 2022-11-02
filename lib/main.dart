import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:providerlearn/app/app.dart';
import 'package:providerlearn/app/dependacyinjection.dart';
import 'package:providerlearn/presentation/resources/languageManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp
  (
    
    EasyLocalization(
      supportedLocales: const [Arabic_Local, English_Local],
      path: AssetPathLocalisation,
      child: 
      Phoenix(child: MyApp())
      )
    
      );
}

