import 'package:flutter/cupertino.dart';
import 'package:fmm_app/pages/home/nav/follow/follow_controller.dart';
import 'package:get/get.dart';

class FollowView extends GetView<FollowController> {
  const FollowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('关注'),
      ),
    );
  }

}