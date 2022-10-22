import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:providerlearn/app/app.dart';
import 'package:providerlearn/app/dependacyinjection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp
  (
    Phoenix(child: MyApp()),
    
    // EasyLocalization(
    //   supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
    //   path: ASSET_PATH_LOCALISATIONS,
    //   child: 
    //   Phoenix(child: MyApp())
      
      
    //   )
    
      );
}
