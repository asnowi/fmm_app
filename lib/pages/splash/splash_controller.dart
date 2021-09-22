import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fmm_app/common/app/index.dart';
import 'package:fmm_app/common/router/app_pages.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with WidgetsBindingObserver {
  late Timer _timer;
  int _count = AppConfig.SPLASH_TIMER;
  int _tick = 0;
  // set count(value) => _count = value;

  get count => _count;
  get tick => _tick;
  get timer => _timer;

  void subCount() {
    _count--;
    _tick++;
    update(['count']);
  }

  @override
  void onInit() {
    _count = AppConfig.SPLASH_TIMER;
    _tick = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Logger.ggq('-----splash----->>${timer.tick}');
      subCount();
      if (timer.tick >= AppConfig.SPLASH_TIMER) {
        _timer.cancel();
        launchTarget();
      }
    });
    WidgetsBinding.instance?.addObserver(this);
    super.onInit();
  }

  void launchTarget() {
    if (Global.hasStarted) {
        Get.offNamed(AppRoutes.home);
     } else {
        Get.offNamed(AppRoutes.welcome);
     }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Logger.ggq('app进入前台');
      // applyPermissions(context);
    } else if (state == AppLifecycleState.inactive) {
      Logger.ggq('app在前台但不响应事件，比如电话，touch id等');
    } else if (state == AppLifecycleState.paused) {
      Logger.ggq('app进入后台');
    } else if (state == AppLifecycleState.detached) {
      Logger.ggq('没有宿主视图但是flutter引擎仍然有效');
      timerCancel();
    }
    super.didChangeAppLifecycleState(state);
  }

  void timerCancel () {
    _count = AppConfig.SPLASH_TIMER;
    _tick = 0;
    _timer.cancel();
    Logger.ggq('------------->>');
  }
  @override
  void dispose() {
    timerCancel();
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }
}
