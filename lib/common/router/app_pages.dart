import 'package:fmm_app/pages/home/home_binding.dart';
import 'package:fmm_app/pages/home/home_view.dart';
import 'package:fmm_app/pages/home/nav/blog/blog_binding.dart';
import 'package:fmm_app/pages/home/nav/blog/blog_view.dart';
import 'package:fmm_app/pages/home/nav/find/find_binding.dart';
import 'package:fmm_app/pages/home/nav/find/find_view.dart';
import 'package:fmm_app/pages/home/nav/follow/follow_binding.dart';
import 'package:fmm_app/pages/home/nav/follow/follow_view.dart';
import 'package:fmm_app/pages/home/nav/mine/mine_binding.dart';
import 'package:fmm_app/pages/home/nav/mine/mine_view.dart';
import 'package:fmm_app/pages/login/login_binding.dart';
import 'package:fmm_app/pages/login/login_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {

  static const INITIAL = AppRoutes.home;

  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),

      children: [
        GetPage(
            name: AppRoutes.navFind,
            page: () => const FindView(),
            binding: FindBinding()
        ),
        GetPage(
            name: AppRoutes.navBlog,
            page: () => const BlogView(),
            binding: BlogBinding()
        ),
        GetPage(
            name: AppRoutes.navFollow,
            page: () => const FollowView(),
            binding: FollowBinding()
        ),
        GetPage(
            name: AppRoutes.navMine,
            page: () => const MineView(),
            binding: MineBinding()
        )
      ]
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    )
  ];

  // 找不到去登录页
  static final unknownRoute = GetPage(
    name: AppRoutes.login,
    page: () => const LoginView(),
    binding: LoginBinding(),
    transitionDuration: const Duration(milliseconds: 300),
  );
}