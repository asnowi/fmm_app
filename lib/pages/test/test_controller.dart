
import 'dart:async';
import 'dart:math';

import 'package:fmm_app/common/widget/state/index.dart';
import 'package:get/get.dart';

class TestController extends GetxController with StateMixin<PageState>{


  late Timer _timer;

  final Random r = Random();

  @override
  void onInit() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int x = r.nextInt(5);
      if (x == 1) {
        change(null, status: RxStatus.empty());
      } else if (x == 2) {
        change(null, status: RxStatus.error('错误！！${timer.tick}'));
      } else if (x == 3) {
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.loading());
      }
    });
    super.onInit();
  }
  @override
  void onReady() {
    change(null, status: RxStatus.loading());
    super.onReady();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

}