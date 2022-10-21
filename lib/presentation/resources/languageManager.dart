// ignore_for_file: file_names, non_constant_identifier_names


// ignore: constant_identifier_names
enum LanguageType  { ENGLISH,Arabic }

extension LanguageTypeExtension on LanguageType {
  String get LanguageName {
    switch (this) {
      case LanguageType.ENGLISH:
        return "en";
      case LanguageType.Arabic:
        return "ar";
    }
  }
}


