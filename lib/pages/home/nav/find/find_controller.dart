import 'package:fmm_app/common/router/app_pages.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:fmm_app/pages/home/home_controller.dart';
import 'package:get/get.dart';

class FindController extends GetxController {

  HomeController? _homeController;
  void launch () {
    Get.toNamed(AppRoutes.test);
  }
  @override
  void onInit() {
    Logger.ggq('---onInit---->>> find');
    super.onInit();
  }

  @override
  void onReady() {
    _homeController =  Get.find<HomeController>();
    super.onReady();
  }
}