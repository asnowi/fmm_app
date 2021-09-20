import 'package:flutter/material.dart';
import 'package:fmm_app/common/utils/index.dart';
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
    return HomeBody(
      controller: controller,
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key, HomeController? controller}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final PageController _pageController;
  late final AnimationController _animationController;

  final List<Widget> _pageList = [
    const FindView(),
    const BlogView(),
    const FollowView(),
    const MineView()
  ];

  final List<String> tabIcon = [
    AssetsProvider.lottiePath('tab_find'),
    AssetsProvider.lottiePath('tab_blog'),
    AssetsProvider.lottiePath('tab_follow'),
    AssetsProvider.lottiePath('tab_mine')
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
    return Scaffold(
      extendBody: false,
      resizeToAvoidBottomInset: false,
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _pageList,
          onPageChanged: (page) {
            Logger.ggq("page:${page}");
          }),
      bottomNavigationBar: _buildBottomAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    // final itemWidth = CommonUtils.getWidth()/5;
    final double itemWidth = getWidth() / 4;
    return BottomAppBar(
      elevation: 6,
      notchMargin: 6.0,
      color: Colors.white,
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
    return InkWell(
      splashColor: ThemeData.light().colorScheme.primary,
      child: Center(
        child: Container(
            child: Lottie.asset(tabIcon[index], height: 50, repeat: false)),
      ),
      onTap: () {
        setState(() {
          _currentIndex = index;
          _pageController.animateToPage(_currentIndex,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 260));
        });
      },
    );
  }

  /// 是否缓存tab页面数据
  @override
  bool get wantKeepAlive => false;
}
