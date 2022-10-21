// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_field, prefer_final_fields, non_constant_identifier_names, unused_local_variable
import 'package:providerlearn/presentation/resources/languageManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
