import 'package:fmm_app/common/utils/index.dart';

class FormatUtils {

  /// 格式化手机号 如：137 1759 1366
  static String formatPhone(String? phone){
    if(StringUtils.isEmpty(phone) || phone?.length != 11){
      return '$phone';
    }
    String a = phone!.substring(0,3);
    String b = phone.substring(3,7);
    String c = phone.substring(7,11);
    return '$a $b $c';
  }
}