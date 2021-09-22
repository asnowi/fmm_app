import 'package:fmm_app/common/utils/index.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MineController extends GetxController {


  final RefreshController refreshController = RefreshController();

  ///  允许下拉
  final bool enablePullDown = true;
  ///  允许上拉加载
  final bool enablePullUp = false;

  @override
  void onInit() {
    Logger.ggq('---onInit---->>> mine');
    super.onInit();
  }
}