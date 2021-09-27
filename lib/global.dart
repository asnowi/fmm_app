import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fmm_app/common/app/config/const.dart';
import 'package:fmm_app/common/db/index.dart';
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

  /// db
  static late DBUtil dbUtil;

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();
    //竖屏
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);

    // 工具初始
    await StorageUtil().init();
    // hive
    await DBUtil.install();
    dbUtil = await DBUtil.getInstance();
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
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskColor = Colors.black
      ..backgroundColor = Colors.black
      ..indicatorColor = Colors.white
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      ..textColor = Colors.white
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..indicatorSize = 32
      ..radius = 8
      ..fontSize = 12
      ..contentPadding = const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      )
      ..indicatorWidget = Container(
        color: Colors.black,
        width: 42,
        height: 42,
        child: Lottie.asset(AssetsProvider.lottiePath('loading')),
      )
    // ..dismissOnTap = false;
      ..dismissOnTap = true;
    Get.put(ThemeController());
  }
}
