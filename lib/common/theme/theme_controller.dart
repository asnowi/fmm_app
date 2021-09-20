import 'package:flutter/material.dart';
import 'package:fmm_app/common/theme/index.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  /// 0 亮色,  1 深色
   var _themeMode = 0;

  get themeMode => _themeMode;

  void setThemeMode(value) {
    _themeMode = value;
  }

   void changeTheme () {
    late ThemeData theme;
     if (themeMode == 0) {
       /// 切换为深色
       setThemeMode(1);
       theme = ThemeDataProvider.darkThemeData();
     } else {
      /// 切换为亮色
       setThemeMode(0);
       theme = ThemeDataProvider.lightThemeData();
     }
     Get.changeTheme(theme);
     update();
   }
}