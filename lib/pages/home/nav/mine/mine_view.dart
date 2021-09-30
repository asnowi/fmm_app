import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fmm_app/common/db/index.dart';
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
            onPressed: () async{
              // ToastUtil.show('menu');
              if(controller.isLogin()) {
                _scaffoldKey.currentState?.openDrawer();
              } else {
                final result = await Get.toNamed(AppRoutes.login);
                if(result) {
                  controller.updateUser();
                }
              }
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
              onPressed: () async{
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
            child: _buildContent()));
  }

  Widget _buildDrawer(BuildContext context) {
    double _drawerHeight = Get.height - Get.statusBarHeight - Get.bottomBarHeight;
    Logger.ggq('---height---->>${Get.height}');
    Logger.ggq('---_scaffoldKey-height--->>${ _scaffoldKey.currentContext?.height}');
    Logger.ggq('---_scaffoldKey-width--->>${ _scaffoldKey.currentContext?.width}');
    Logger.ggq('---statusBarHeight---->>${Get.statusBarHeight}');
    Logger.ggq('---bottomBarHeight---->>${Get.bottomBarHeight}');
    return Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        /// 滚动方向，默认是垂直方向
        physics: const BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              _buildDrawerHeader(),
              _buildDrawerContent(_drawerHeight * 0.6),
              _buildDrawerLogout()
            ],
          ),
        ),
      )
    );
  }
  Widget _buildDrawerContent(double _height) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: _height),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            height: 200.h,
            child: const Text('侧滑菜单'),
          )
        ],
      ),
    );
  }
  Widget _buildDrawerHeader() {
    return const DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
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
        )
    );
  }
  Widget _buildDrawerLogout() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextButton(onPressed: () async{
        int result = await Global.dbUtil.clearUser();
        if(result >= 1 ){
          _scaffoldKey.currentState?.openEndDrawer();
          controller.updateUser();
        } else {
          ToastUtil.show('请重试！');
        }
      },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states){
                if(states.contains(MaterialState.disabled)){
                  return Colors.white60;
                }
                return Colors.white;
              })
          ),
          child: SizedBox(
            width: Get.width,
            height: 30.h,
            child: Center(
              child: Text('退出登录',style: TextStyle(
                fontSize: 14.sp,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),),
            ),
          )
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
            _buildColumn()
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
            width: 0.9.sw,
            child:
            (controller.isLogin())? _buildHeaderIn(controller.user!) : _buildHeaderUn()));
  }

  Widget _buildHeaderIn(User user) {
    return Row(
      children: [
        ClipOval(child: ImageLoader.load(url: user.avatarImg, width: 82.r, height: 82.r)),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h)),
        Text(user.phone)
      ],
    );
  }

  Widget _buildHeaderUn() {
    return InkWell(
      onTap: () async {
        final result = await Get.toNamed(AppRoutes.login);
        Logger.ggq('--result-->>${result}');
        if(result) {
          controller.updateUser();
        }
      },
      child: Row(
        children: [
          Image.asset(AssetsProvider.imagePath('ic_avatar'),
              width: 82.w, height: 82.w),
          Padding(padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h)),
          const Text('点击登录')
        ],
      ),
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
                        if(controller.isLogin()) {
                          ToastUtil.show('${index}');
                        } else {
                          ToastUtil.show('请登录');
                        }
                      },
                      splashColor: Colors.blueGrey.shade100,
                      highlightColor: Colors.blueGrey.shade50,
                      elevation: 4.0,
                      shape: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipOval(
                          child: Image.asset(AssetsProvider.imagePath('nav')),
                        ),
                      ),)
                );
              }),
        ),
      )
    );
  }

  Widget _buildDivider(){
    return Divider(
      height: .5,
      thickness: .5,
      color: Colors.grey[100],
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
                  // ToastUtil.show('设置');
                  if(controller.isLogin()) {
                    ToastUtil.show('设置');
                  } else {
                    ToastUtil.show('请登录');
                  }
                },
                child: SizedBox(
                  width: 0.9.sw,
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
            _buildDivider(),
            MaterialButton(
                onPressed: (){
                  // ToastUtil.show('设置');
                  if(controller.isLogin()) {
                    ToastUtil.show('设置');
                  } else {
                    ToastUtil.show('请登录');
                  }
                },
                child: SizedBox(
                  width: 0.9.sw,
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
            _buildDivider(),
            MaterialButton(
                onPressed: (){
                  // ToastUtil.show('设置');
                  if(controller.isLogin()) {
                    ToastUtil.show('设置');
                  } else {
                    ToastUtil.show('请登录');
                  }
                },
                child: SizedBox(
                  width: 0.9.sw,
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
            _buildDivider(),
            MaterialButton(
                onPressed: (){
                  // ToastUtil.show('设置');
                  if(controller.isLogin()) {
                    ToastUtil.show('设置');
                  } else {
                    ToastUtil.show('请登录');
                  }
                },
                child: SizedBox(
                  width: 0.9.sw,
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
            _buildDivider(),
            MaterialButton(
                onPressed: (){
                  // ToastUtil.show('设置');
                  if(controller.isLogin()) {
                    ToastUtil.show('设置');
                  } else {
                    ToastUtil.show('请登录');
                  }
                },
                child: SizedBox(
                  width: 0.9.sw,
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
            _buildDivider(),
            MaterialButton(
                onPressed: (){
                  // ToastUtil.show('设置');
                  if(controller.isLogin()) {
                    ToastUtil.show('设置');
                  } else {
                    ToastUtil.show('请登录');
                  }
                },
                child: SizedBox(
                  width: 0.9.sw,
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
          ],
        )
      ),
    );
  }
}
