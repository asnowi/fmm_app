import 'package:fmm_app/pages/home/nav/follow/follow_controller.dart';
import 'package:get/get.dart';

class FollowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowController>(() => FollowController());
  }

}