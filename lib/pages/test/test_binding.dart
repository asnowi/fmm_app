import 'package:fmm_app/pages/test/test_controller.dart';
import 'package:get/get.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestController>(() => TestController());
  }
}