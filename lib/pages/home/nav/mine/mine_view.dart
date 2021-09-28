import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmm_app/common/router/app_pages.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:fmm_app/common/values/index.dart';
import 'package:fmm_app/pages/home/nav/mine/mine_controller.dart';
import 'package:get/get.dart';

class MineView extends GetView<MineController> {
  MineView({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


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
        key: _scaffoldKey,
        drawer: _buildDrawer(context),
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              // ToastUtil.show('menu');
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.menu_sharp,
              size: 18,
              color: Colors.grey,
            ),
          ),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: AppColors.background,
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

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  child: Text('R'),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
          )
        ],
      ),
    );
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
        builder: (_) => SizedBox(
            width: Get.width * 0.9,
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
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Card(
        color: Colors.white, // 背景色
        shadowColor: Colors.blueGrey.shade50, // 阴影颜色
        elevation: 0.2, // 阴影高度
        borderOnForeground: false, // 是否在 child 前绘制 border，默认为 true
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: GridView.builder(
            //解决无限高度问题
              shrinkWrap: true,
              //禁用滑动事件
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, //每行4列
                childAspectRatio: 1.5, //显示区域宽高相等
              ),
              padding: EdgeInsets.zero,
              itemCount: _gridList.length,
              itemBuilder: (context, index) {
                return Center(
                    child: MaterialButton(
                      onPressed: (){
                        ToastUtil.show('${index}');
                      },
                      splashColor: Colors.blueGrey.shade100,
                      highlightColor: Colors.blueGrey.shade50,
                      elevation: 4.0,
                      shape: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipOval(
                          child: ImageLoader.load(url: 'http://p1.music.126.net/GE2kVDwdVQyoNJC8k31mEA==/18979769718754963.jpg'),
                        ),
                      ),)
                );
              }),
        ),
      )
    );
  }

  Widget _buildColumn() {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: Get.height * 0.34),
      child: Container(
        width: Get.width,
        child: Column(
          children: [
            MaterialButton(
                onPressed: (){
                  ToastUtil.show('设置');
                },
                child: SizedBox(
                  width: Get.width * 0.9,
                  height: 50.h,
                  child: Row(
                    children: const [
                      Icon(Icons.settings, size: 16,),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                      Text('设置')
                    ],
                  ),
                )
            ),
            MaterialButton(
                onPressed: (){
                  ToastUtil.show('设置');
                },
                child: SizedBox(
                  width: Get.width * 0.9,
                  height: 50.h,
                  child: Row(
                    children: const [
                      Icon(Icons.settings, size: 16,),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                      Text('设置')
                    ],
                  ),
                )
            ),
            MaterialButton(
                onPressed: (){
                  ToastUtil.show('设置');
                },
                child: SizedBox(
                  width: Get.width * 0.9,
                  height: 50.h,
                  child: Row(
                    children: const [
                      Icon(Icons.settings, size: 16,),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                      Text('设置')
                    ],
                  ),
                )
            ),
            MaterialButton(
                onPressed: (){
                  ToastUtil.show('设置');
                },
                child: SizedBox(
                  width: Get.width * 0.9,
                  height: 50.h,
                  child: Row(
                    children: const [
                      Icon(Icons.settings, size: 16,),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                      Text('设置')
                    ],
                  ),
                )
            )
          ],
        )
      ),
    );
  }
}
