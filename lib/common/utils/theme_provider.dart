import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider {

  static ThemeData appTheme () {
    return ThemeData(
          appBarTheme: AppBarTheme(
          color: Colors.white,
          backgroundColor: Colors.redAccent,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarDividerColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark
          ),
        ),
    );
  }
}