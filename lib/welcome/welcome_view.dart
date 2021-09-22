import 'package:flutter/material.dart';
import 'package:fmm_app/common/router/app_pages.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:fmm_app/welcome/welcome_controller.dart';
import 'package:get/get.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);

  List<Widget> _page(context) {
    return [
      _buildItem(context,1),
      _buildItem(context,2),
      _buildItem(context,3),
      _buildItem(context,4),
    ];
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      Logger.ggq('--WelcomeView--->> addListener');
    });
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        width: Get.width,
        height: Get.height,
        child: PageView(
          scrollDirection: Axis.horizontal,
          reverse: false,
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
            keepPage: true,
          ),
          physics: const BouncingScrollPhysics(),
          pageSnapping: true,
          onPageChanged: (index) {
            //监听事件
            Logger.ggq('-------page-------->>${index}');
          },
          children: _page(context),
        ),
      )
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if(index == 4) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Center(child: Text('${index}')),
          Positioned(
            bottom: 30.h,
            child: ElevatedButton(
              onPressed: (){
                Get.offNamed(AppRoutes.home);
              },
              child: const Text('立即体验'),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.blue),                //背景颜色
                foregroundColor: MaterialStateProperty.all(Colors.white),                //字体颜色
                overlayColor: MaterialStateProperty.all(Colors.white60),                   // 高亮色
                textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16)),                //字体
                shape: MaterialStateProperty.all(
                    const StadiumBorder(
                        side: BorderSide(
                          //设置 界面效果
                          color: Colors.blueGrey,
                          style: BorderStyle.solid,
                        )
                    )
                ),
              ),
            ),
          )
        ],
      );
    }
    return Center(child: Text('${index}'));
  }

}