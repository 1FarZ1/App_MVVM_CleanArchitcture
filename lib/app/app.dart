// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme:getApplicationTheme(),

    );
  }
}
