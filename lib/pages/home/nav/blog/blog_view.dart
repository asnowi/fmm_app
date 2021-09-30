import 'package:flutter/cupertino.dart';
import 'package:fmm_app/pages/home/nav/blog/blog_controller.dart';
import 'package:get/get.dart';

class BlogView extends GetView<BlogController> {
  BlogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        key: UniqueKey(),
        ///透明度
        opacity: controller.opacityLevel,
        ///过渡时间
        duration: const Duration(milliseconds: 2000),
        ///动画插值器
        curve: Curves.linear,
        child: const Text('博客'),
      ),
    );
  }

}