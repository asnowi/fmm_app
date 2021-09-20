import 'package:fmm_app/pages/home/home_view.dart';
import 'package:fmm_app/pages/login/login_binding.dart';
import 'package:fmm_app/pages/login/login_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {

  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
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
    transitionDuration: const Duration(milliseconds: 300),
  );
}