import 'package:fmm_app/common/app/index.dart';
import 'package:get/get.dart';

/// 全局响应数据
class GlobalService extends GetxService {

  /// 发布渠道
  var channel = ''.obs;
  var os = ''.obs;
  Future<GlobalService> init() async {
    channel.value = 'official';
    if(Global.isIOS) {
      os.value = 'IOS';
    } else if(Global.isAndroid) {
      os.value = 'Android';
    }
    return this;
  }
}