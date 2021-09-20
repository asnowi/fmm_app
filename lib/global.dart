import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Global{
  /// 是否 release
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");
  /// 是否启动过
  static bool hasStarted = false;

  /// 是否 ios
  static bool isIOS = Platform.isIOS;
  /// 是否 android
  static bool isAndroid = Platform.isAndroid;

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();


    //  android 状态栏为透明的沉浸
    if (isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarDividerColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}