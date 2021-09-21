import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fmm_app/common/app/config/const.dart';
import 'package:fmm_app/common/theme/index.dart';
import 'package:get/get.dart';

import 'common/utils/index.dart';

class Global {
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
    // 工具初始
    await StorageUtil().init();

    // 第一次打开应用
    hasStarted = StorageUtil().getBool(SaveInfoKey.HAS_STARTED)?? false;
    //  android 状态栏为透明的沉浸
    if (isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarDividerColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    Get.put(ThemeController());
  }
}
