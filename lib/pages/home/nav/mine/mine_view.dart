import 'package:flutter/material.dart';
import 'package:fmm_app/common/db/index.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:fmm_app/common/values/index.dart';
import 'package:fmm_app/pages/home/nav/mine/mine_controller.dart';
import 'package:get/get.dart';

class MineView extends GetView<MineController> {
  MineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppColors.background,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            ToastUtil.show('menu');
          },
          icon: const Icon(
            Icons.menu,
            size: 18,
            color: Colors.grey,
          ),
        ),
        actions: <Widget>[
          IconButton(
            splashRadius: 20,
            onPressed: () {
              ToastUtil.show('scan');
            },
            icon: const Icon(
              Icons.zoom_out_map,
              size: 18,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        color: AppColors.background,
        child: _buildContent()
      )
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical, /// 滚动方向，默认是垂直方向
      physics: const BouncingScrollPhysics(), /// 弹性
      controller: controller.scrollController,
      child: Container(
        child: Column(
          children: [
           _buildHeader(),
           _buildGride(),
           _buildColumn(),
           _buildFooter(),
            TextButton(onPressed: () async{
              if(Global.dbUtil.isLogin()){
                int result = await Global.dbUtil.clearUser();
                Logger.ggq('------clearUser---->>${result}');
              } else {
                final User user = User('0x0012','13717591362','1234562','avatarImg');
                int result = await Global.dbUtil.saveUser(user);
                Logger.ggq('-----saveUser----->>${result}');
              }
              controller.updateUser();
            }, child: GetBuilder<MineController>(
                id: 'user',
                builder: (_) => Text(Global.dbUtil.isLogin()? '已登录' : '未登录')
            ))
          ],
        ),
        color: AppColors.background,
      ),
    );
  }

  Widget _buildHeader(){
    return GetBuilder<MineController> (
        id: 'user',
        builder: (_) => Container(
            padding: EdgeInsets.symmetric(horizontal: 0.1.sw),
            child: Global.dbUtil.isLogin()? _buildHeaderIn() : _buildHeaderUn()
        )
    );
  }

  Widget _buildHeaderIn() {
    return Row(
      children: [
        Image.asset(AssetsProvider.imagePath('ic_avatar'), width: 82.w, height: 82.w),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h)),
        Text(Global.dbUtil.getUser()?.phone??'')
      ],
    );
  }

  Widget _buildHeaderUn(){
    return Row(
      children: [
        Image.asset(AssetsProvider.imagePath('ic_avatar'), width: 82.w, height: 82.w),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h)),
        const Text('点击登录')
      ],
    );
  }


  Widget _buildFooter(){
    return GetBuilder<MineController> (
        id: 'user',
        builder: (_) => Container(
          child: Global.dbUtil.isLogin()? _buildFooterIn() : _buildFooterUn()
        )
    );
  }

  Widget _buildFooterIn(){
    return Text('退出登录');
  }

  Widget _buildFooterUn(){
    return Text('点击登录');
  }

  Widget _buildGride(){
    return Text('_buildGride');
  }

  Widget _buildColumn(){
    return Text('_buildColumn');
  }
}
