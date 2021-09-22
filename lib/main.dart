import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fmm_app/common/router/app_pages.dart';
import 'package:fmm_app/common/theme/index.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/app/index.dart';
import 'common/langs/index.dart';
import 'common/utils/index.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  print('starting services ...');
  await Get.putAsync(() => GlobalService().init());
  await Global.init();
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize(),
      builder: () => RefreshConfiguration(
        headerBuilder: () => const WaterDropHeader(),
        // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
        footerBuilder: () => const ClassicFooter(),
        // Configure default bottom indicator
        headerTriggerDistance: 80.0,
        // header trigger refresh trigger distance
        springDescription:
        const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
        // custom spring back animate,the props meaning see the flutter api
        maxOverScrollExtent: 100,
        //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
        maxUnderScrollExtent: 0,
        // Maximum dragging range at the bottom
        enableScrollWhenRefreshCompleted: true,
        //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
        enableLoadingWhenFailed: true,
        //In the case of load failure, users can still trigger more loads by gesture pull-up.
        hideFooterWhenNotFull: false,
        // Disable pull-up to load more functionality when Viewport is less than one screen
        enableBallisticLoad: true,
        // trigger load more by BallisticScrollActivity
        child: GetMaterialApp(
          navigatorKey: navigatorKey,
          title: 'appName'.tr,
          debugShowCheckedModeBanner: false,
          // 网格
          debugShowMaterialGrid: false,
          // 日志
          enableLog: true,
          logWriterCallback: Logger.write,

          // 路由
          getPages: AppPages.routes,
          unknownRoute: AppPages.unknownRoute,

          // 首页
          initialRoute: AppPages.INITIAL,
          builder: EasyLoading.init(),
          // 多语言
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          localeListResolutionCallback: (locales, supportedLocales) {
            print('当前系统语言环境:${locales}');
            return;
          },
          // 主题
          theme: ThemeDataProvider.lightThemeData(),
          darkTheme: ThemeDataProvider.darkThemeData()
        ),
      ),
    );
  }
}
