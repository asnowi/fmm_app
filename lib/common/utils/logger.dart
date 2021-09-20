import 'package:fmm_app/common/utils/index.dart';

class Logger {
  static void ggq(String? msg) {
    if(!Global.isRelease) {
      if(StringUtils.isEmpty(msg)) {
        LogUtil.e('-->>> null',tag: 'GGQ');
      } else {
        LogUtil.e(msg,tag: 'GGQ');
      }
    }
  }

  static void write(String? text, {bool isError = false}) {
    if(!Global.isRelease) {
      Future.microtask(() => print('** $text. isError: [$isError]'));
    }
  }
}
