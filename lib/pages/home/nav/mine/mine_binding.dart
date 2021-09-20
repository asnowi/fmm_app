import 'package:fmm_app/pages/home/nav/mine/mine_controller.dart';
import 'package:get/get.dart';

class MineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineController>(() => MineController());
  }

}