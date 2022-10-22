// ignore_for_file: file_names
import 'package:flutter/material.dart';
// 1. Color Manager (Farz Bek) --- My Knowledge ---
// This is My First Guided Comment ||  i will Start with the most easy Class in Project The ColorManager,
// so instead of Hard Code values in the code we will use this class to get the colors from it
// so we will have a single source of truth for the colors
// and its better for the maintainability of the code
// and we will use it in the ThemeManager
// and for the perfomance we will use the const keyword to make the color constant
// and we will use the static keyword to make the color static so we can access it without creating an instance of the class
// and its easier to change the colors of the app from one place only (the ColorManager)
//instead of searching for the color in the code and change it from there

class ColorManager {
  static Color primary = const Color(0xff9D92FF);
  static Color darkGrey = const Color(0xff525252);
  static Color grey = const Color(0xff737477);
  static Color lightGrey = const Color(0xff9E9E9E);
  static Color black = const Color(0xff000000);

  // new colors
  static Color darkPrimary = const Color(0xffd17d11);
  static Color lightPrimary = const Color(0xCCd17d11); // color with 80% opacity
  static Color grey1 = const Color(0xff707070);
  static Color grey2 = const Color(0xff797979);
  static Color white = const Color(0xffFFFFFF);
  static Color error = const Color(0xffe61f34); //

}
