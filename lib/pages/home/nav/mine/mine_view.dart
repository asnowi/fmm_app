import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fmm_app/pages/home/nav/mine/mine_controller.dart';
import 'package:get/get.dart';

class MineView extends GetView<MineController>{
  const MineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('我的'),
      ),
    );
  }

}