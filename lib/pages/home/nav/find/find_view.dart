import 'package:flutter/material.dart';
import 'package:fmm_app/pages/home/nav/find/find_controller.dart';
import 'package:get/get.dart';

class FindView extends GetView<FindController> {
  const FindView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: TextButton(onPressed: (){
        }, child: Text('发现'))
      ),
    );
  }
}
