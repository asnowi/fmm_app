import 'package:fmm_app/common/utils/index.dart';
import 'package:get/get.dart';

class FindController extends GetxController {

  @override
  void onInit() {
    Logger.ggq('---onInit---->>> find');
    super.onInit();
  }

  void clearStorage () {
    StorageUtil().clear();
  }

}