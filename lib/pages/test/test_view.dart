import 'package:flutter/material.dart';
import 'package:fmm_app/pages/test/test_controller.dart';
import 'package:get/get.dart';

class TestView extends GetView<TestController> {
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('test'),
    );
  }

}