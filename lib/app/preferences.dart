// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_field, prefer_final_fields, non_constant_identifier_names, unused_local_variable, constant_identifier_names
import 'package:providerlearn/presentation/resources/languageManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(
    this._sharedPreferences,
  );
  Future<String> GetApplicationLanguage() async {
    String? Language = _sharedPreferences.getString('ApplicationLanguage');
    if (Language != null && Language.isNotEmpty) {
      return Language;
    } else {
      return LanguageType.ENGLISH.LanguageName;
    }
  }

  Future<void> setOnBoardingScreenViewed() async {
   await _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }
   Future<void> setIsLoggedIn() async {
    await _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

   Future<bool?> IsLoggedIn() async {
    return  _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN);
  }
    Future<bool?> OnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED);
  }
  
  

}
