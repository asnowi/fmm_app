import 'package:flutter/material.dart';
import 'package:fmm_app/common/theme/index.dart';

class ThemeDataProvider {
    static ThemeData lightThemeData () {
      return ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          backgroundColor: Colors.white
      );
    }

    static ThemeData darkThemeData () {
      return ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          backgroundColor: Colors.blueGrey
      );
    }


    static ThemeData getThemeData () {
      late ThemeData theme;
      if (ThemeController.themeMode == 0) {
        theme = ThemeDataProvider.darkThemeData();
      } else {
        theme = ThemeDataProvider.lightThemeData();
      }
      return theme;
    }
}