import 'package:flutter/material.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:fmm_app/common/values/index.dart';
import 'package:fmm_app/common/widget/refresh/index.dart';
import 'package:fmm_app/pages/home/nav/mine/mine_controller.dart';
import 'package:get/get.dart';

class MineView extends GetView<MineController>{
  const MineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: AppColors.background,
      child: Refresh(controller.refreshController, _buildContent(),onRefresh: _onRefresh, enablePullUp: controller.enablePullUp, enablePullDown: controller.enablePullDown),
    );
  }

  void _onRefresh() {
    DelayedUtil.delayed(() {
      if(controller.refreshController.isRefresh){
        controller.refreshController.refreshToIdle();
      }
    });
  }

  Widget _buildContent(){
    return ListView.builder(itemBuilder: (BuildContext context, int index) => _buildItem(context,index),itemCount: 10);
  }

  Widget _buildItem(BuildContext context, int index){
    return Center(
      child: Container(
        child: Text('${index}'),
      ),
    );
  }

}