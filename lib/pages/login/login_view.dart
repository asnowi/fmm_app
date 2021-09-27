import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:fmm_app/pages/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class LoginView extends GetView<LoginController>{
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          _buildPlayer(context)
        ],
      )
    );
  }


  /// 使用Transform.scale对视频进行缩放，
  /// 我们想要的效果就是不管视频是什么比率，
  /// 都可以平铺无拉伸的显示。Center让视频放大以后居中显示，
  /// 缩放比为_controller.value.aspectRatio /MediaQuery.of(context).size.aspectRatio，
  /// 用视频的宽高比除以设备的宽高比。
  Widget _buildPlayer(BuildContext context) {
    return GetBuilder<LoginController>(
      id: 'player',
      builder: (_) => Transform.scale(
        scale: controller.videoPlayerController.value.aspectRatio / MediaQuery.of(context).size.aspectRatio * 1.01,
        child: Center(
          child: Container(
            child: controller.videoPlayerController.value.isInitialized ?
            AspectRatio(aspectRatio: controller.videoPlayerController.value.aspectRatio,child: VideoPlayer(controller.videoPlayerController)): Container(
              color: Colors.white,
              width: 42,
              height: 42,
              child: Lottie.asset(AssetsProvider.lottiePath('loading')),
            ),
          ),
        ),
      ),
    );
  }

}