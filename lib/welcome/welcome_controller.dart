import 'package:fmm_app/common/app/index.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController{

  // late Worker worker;

  @override
  void onInit() {
    // worker = debounce<int>(1.obs, (latestValue){
    //   Logger.ggq('----按钮防抖---->debounce->${latestValue}');
    // }, onDone: () {
    //   Logger.ggq('----按钮防抖---->onDone');
    // }, onError: () {
    //   Logger.ggq('----按钮防抖---->onError');
    // },
    // time: const Duration(seconds: 1));
    super.onInit();
  }

  @override
  void onReady() {
    StorageUtil().setBool(SaveInfoKey.HAS_STARTED, true);
    Global.hasStarted = true;
    super.onReady();
  }


  @override
  void onClose() {
    // worker.dispose();
    super.onClose();
  }
}