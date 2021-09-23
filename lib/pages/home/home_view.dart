import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmm_app/common/theme/index.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:fmm_app/common/values/index.dart';
import 'package:fmm_app/common/widget/tab/index.dart';
import 'package:fmm_app/pages/home/home_controller.dart';
import 'package:fmm_app/pages/home/nav/blog/blog_view.dart';
import 'package:fmm_app/pages/home/nav/find/find_view.dart';
import 'package:fmm_app/pages/home/nav/follow/follow_view.dart';
import 'package:fmm_app/pages/home/nav/mine/mine_view.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return HomeBody(controller);
  }
}

class HomeBody extends StatefulWidget {
  final HomeController homeController;
  const HomeBody(this.homeController, {Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();

}

class _HomeBodyState extends State<HomeBody>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final PageController _pageController;
  late final AnimationController _animationController;
  /// 点击退出 APP
  DateTime? _popTime;

  final List<Widget> _pageList = [
     FindView(),
     BlogView(),
     FollowView(),
     MineView()
  ];

  final List<String> tabLottie = [
    AssetsProvider.lottiePath('tab_find'),
    AssetsProvider.lottiePath('tab_blog'),
    AssetsProvider.lottiePath('tab_follow'),
    AssetsProvider.lottiePath('tab_mine')
  ];
  final List<String> tabIcon = [
    AssetsProvider.imagePath('tab_find'),
    AssetsProvider.imagePath('tab_blog'),
    AssetsProvider.imagePath('tab_follow'),
    AssetsProvider.imagePath('tab_mine')
  ];

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        extendBody: false,
        resizeToAvoidBottomInset: false,
        body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _pageList,
            onPageChanged: (page) {
              Logger.ggq('page:${page}');
            }),
        bottomNavigationBar: _buildBottomAppBar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
      onWillPop: () async {
        if(_popTime == null || DateTime.now().difference(_popTime?? DateTime.now()) > const Duration(seconds: 2)){
          //两次点击时间间隔超过1秒则重新计时
          ToastUtil.show('再按一次退出');
          _popTime = DateTime.now();
          return false;
        }
        // 退出app
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return true;
      }
    );
  }

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    // final itemWidth = CommonUtils.getWidth()/5;
    final double itemWidth = getWidth() / 4;
    return BottomAppBar(
      elevation: 6,
      notchMargin: 6.0,
      color: AppColors.background,
      shape: const CustomCircularNotchedRectangle(),
      child: Row(
        children: [
          SizedBox(height: 58, width: itemWidth, child: _buildItemBar(0)),
          SizedBox(height: 58, width: itemWidth, child: _buildItemBar(1)),
          SizedBox(height: 58, width: itemWidth, child: _buildItemBar(2)),
          SizedBox(height: 58, width: itemWidth, child: _buildItemBar(3)),
        ],
      ),
    );
  }

  Widget _buildItemBar(int index) {
    Logger.ggq('---------->>${tabIcon[index]}');
    return MaterialButton(onPressed: (){
      setState(() {
        _currentIndex = index;
        _pageController.animateToPage(_currentIndex,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 260));
      });
    }, child: _buildItemBox(_currentIndex,index),
       // splashColor: ThemeDataProvider.getThemeData().primaryColor,
       splashColor: Colors.blueGrey.shade100,
       highlightColor: Colors.blueGrey.shade50,
       elevation: 0.0,
       shape: const CircleBorder()
    );
  }

  Widget _buildItemBox (int currentIndex,int index) {
    return Center(
      child: Container(
        child: (currentIndex == index)? Lottie.asset(tabLottie[index], width: 50, height: 50, repeat: false): Image.asset(tabIcon[index], width: 50, height: 50),
      ),
    );
  }

  /// 是否缓存tab页面数据
  @override
  bool get wantKeepAlive => false;
}
