import 'package:flutter/material.dart';
import 'package:fmm_app/common/utils/index.dart';

import 'package:get/get.dart';

import 'en_US.dart';
import 'zh_CN.dart';

/*

https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html
https://www.ibabbleon.com/iOS-Language-Codes-ISO-639.html

*/

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  // static const fallbackLocale = Locale('en', 'US');
  // static Locale fallbackLocale = Locale('zh', 'CN');
  static Locale fallbackLocale = locale?? Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'zh_CN': zh_CN,
      };


  /// 切换语言  zh -> 简体中文  en -> 英语
  static changeLocale () {
    Logger.ggq('------切换语言----->> ${fallbackLocale.languageCode}');
    if(fallbackLocale.languageCode == 'en') {
      fallbackLocale = Locale('zh', 'CN');
    } else {
      fallbackLocale = Locale('en', 'US');
    }
    Get.updateLocale(fallbackLocale);
  }
}
