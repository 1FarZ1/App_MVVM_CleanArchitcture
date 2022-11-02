// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:providerlearn/app/dependacyinjection.dart';
import 'package:providerlearn/app/preferences.dart';
import 'package:providerlearn/presentation/resources/RoutesManager.dart';
import 'package:providerlearn/presentation/resources/ThemeManager.dart';

class MyApp extends StatefulWidget {
  // const MyApp({super.key}); // Default constructor

  // named Constructor
  // we use this to make all instances  of this classes to have the same instances and share the same data  (ki tcriyi class mno  2 fois its the same instance)
  MyApp._internal();

  

  static final MyApp _instance = MyApp._internal(); //singletoon or single instance 

  factory MyApp() => _instance; // factory 
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appPreferences.getLocal().then((Local) =>context.setLocale(Local));
  }
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme:getApplicationTheme(),

    );
  }
}
