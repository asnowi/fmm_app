import 'package:fmm_app/common/app/index.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {

  @override
  void onInit() {
    StorageUtil().setBool(SaveInfoKey.HAS_STARTED, true);
    Global.hasStarted = true;
    super.onInit();
  }
}