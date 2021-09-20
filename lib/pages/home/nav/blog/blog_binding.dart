import 'package:fmm_app/pages/home/nav/blog/blog_controller.dart';
import 'package:get/get.dart';

class BlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogController>(() => BlogController());
  }

}