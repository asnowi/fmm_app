import 'package:flutter/material.dart';
import 'package:fmm_app/common/router/app_pages.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:fmm_app/common/values/index.dart';
import 'package:fmm_app/pages/home/nav/mine/mine_controller.dart';
import 'package:get/get.dart';

class MineView extends GetView<MineController> {
  MineView({Key? key}) : super(key: key);

  final List<String> _gridList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];

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
                // ToastUtil.show('scan');
                Get.toNamed(AppRoutes.login);
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
            child: _buildContent()));
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,

      /// 滚动方向，默认是垂直方向
      physics: const BouncingScrollPhysics(),

      /// 弹性
      controller: controller.scrollController,
      child: Container(
        child: Column(
          children: [
            _buildHeader(),
            _buildGrid(),
            _buildColumn(),
            _buildFooter()
            // TextButton(onPressed: () async{
            //   if(Global.dbUtil.isLogin()){
            //     int result = await Global.dbUtil.clearUser();
            //     Logger.ggq('------clearUser---->>${result}');
            //   } else {
            //     final User user = User('0x0012','13717591362','1234562','avatarImg');
            //     int result = await Global.dbUtil.saveUser(user);
            //     Logger.ggq('-----saveUser----->>${result}');
            //   }
            //   controller.updateUser();
            // }, child: GetBuilder<MineController>(
            //     id: 'user',
            //     builder: (_) => Text(Global.dbUtil.isLogin()? '已登录' : '未登录')
            // ))
          ],
        ),
        color: AppColors.background,
      ),
    );
  }

  Widget _buildHeader() {
    return GetBuilder<MineController>(
        id: 'user',
        builder: (_) => Container(
            padding: EdgeInsets.symmetric(horizontal: 0.1.sw),
            child:
                Global.dbUtil.isLogin() ? _buildHeaderIn() : _buildHeaderUn()));
  }

  Widget _buildHeaderIn() {
    return Row(
      children: [
        Image.asset(AssetsProvider.imagePath('ic_avatar'),
            width: 82.w, height: 82.w),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h)),
        Text(Global.dbUtil.getUser()?.phone ?? '')
      ],
    );
  }

  Widget _buildHeaderUn() {
    return Row(
      children: [
        Image.asset(AssetsProvider.imagePath('ic_avatar'),
            width: 82.w, height: 82.w),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h)),
        const Text('点击登录')
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      width: Get.width * 0.9,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: GetBuilder<MineController>(
          id: 'user',
          builder: (_) => ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.red[100];
                }
                return Colors.redAccent;
              })),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: const Text(
                  '登录',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))),
    );
  }

  Widget _buildGrid() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: GridView.builder(
        //解决无限高度问题
          shrinkWrap: true,
          //禁用滑动事件
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, //每行4列
            childAspectRatio: 1.3, //显示区域宽高相等
          ),
          padding: EdgeInsets.zero,
          itemCount: _gridList.length,
          itemBuilder: (context, index) {
            return Center(
                child: ElevatedButton(
                  onPressed: (){},
                  child: CircleAvatar(
                    backgroundImage: const NetworkImage('http://p1.music.126.net/GE2kVDwdVQyoNJC8k31mEA==/18979769718754963.jpg'),
                    child: Container(
                      child: Text('${_gridList[index]}'),
                    ),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(CircleBorder()),
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.red[100];
                        }
                        return Colors.redAccent;
                      })),
                ));
          }),
    );
  }

  Widget _buildColumn() {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: Get.height * 0.32),
      child: Container(
        child: Column(
          children: [
            Text('111111'),
          ],
        ),
      ),
    );
  }
}
