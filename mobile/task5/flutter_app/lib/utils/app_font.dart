import 'package:get/get.dart';

class AppFontType {
  AppFontType._internal();

  static final AppFontType _appFontType = AppFontType._internal();

  factory AppFontType() {
    return _appFontType;
  }

  /// Returns the dynamic font based on selected language
  static String get fontFamily {
    final currentLocale = Get.locale?.languageCode ?? 'en';
    return currentLocale == 'kk' ? 'Outfit' : 'Outfit';
  }

  static const String fontFamilyCurrency = "Outfit";
}
