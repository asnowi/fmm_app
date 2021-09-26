import 'package:fmm_app/common/router/app_pages.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:get/get.dart';

class FindController extends GetxController {

  void launch () {
    Get.toNamed(AppRoutes.test);
  }
  @override
  void onInit() {
    Logger.ggq('---onInit---->>> find');
    super.onInit();
  }
}