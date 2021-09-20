import 'package:fmm_app/pages/home/nav/find/find_controller.dart';
import 'package:get/get.dart';

class FindBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindController>(() => FindController());
  }

}