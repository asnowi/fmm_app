import 'package:flutter/material.dart';
import 'package:fmm_app/common/app/index.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:fmm_app/pages/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      Logger.ggq('--SplashView--->> addListener');
    });
    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.pinkAccent,
                    Colors.purple,
                  ],
                ),
              ),
            ),
            Center(
              child: Image.asset(AssetsProvider.imagePath('splash_cool')),
            ),
            Positioned(
              top: 25,
              right: 15,
              child: GetBuilder<SplashController> (
                  id: 'count',
                  builder: (_) => _buildCountdown()
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildCountdown (){
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          strokeWidth: 1,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          value:  controller.tick / AppConfig.SPLASH_TIMER,
        ),
        ElevatedButton(onPressed: (){
          controller.launchTarget();
        },
          child: Text('${controller.count} S'),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.white60),                //背景颜色
            foregroundColor: MaterialStateProperty.all(Colors.blue),                //字体颜色
            overlayColor: MaterialStateProperty.all(Colors.white60),                   // 高亮色
            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 10)),                //字体
            shape: MaterialStateProperty.all(
                const CircleBorder(
                    side: BorderSide(
                      //设置 界面效果
                      color: Colors.blueGrey,
                      style: BorderStyle.none,
                    )
                )
            ),
          ),
        )
      ],
    );
  }
}