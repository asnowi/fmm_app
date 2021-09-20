import 'package:flutter/material.dart';

class ThemeDataProvider {
    static ThemeData lightThemeData () {
      return ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white
      );
    }

    static ThemeData darkThemeData () {
      return ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey
      );
    }


}