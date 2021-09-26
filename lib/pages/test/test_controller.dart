import 'package:fmm_app/common/widget/state/index.dart';
import 'package:get/get.dart';

class TestController extends GetxController with StateMixin<PageState>{

  final PageState _state = PageState();

  @override
  void onReady() {
    change(null, status: RxStatus.loading());
    super.onReady();
  }
}