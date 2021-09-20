import 'package:fmm_app/common/utils/index.dart';

class RegexUtils {

  static isPhone (String? phone) {
    if(StringUtils.isEmpty(phone)) return false;
    return RegexUtil.isMobileExact(phone!);
  }

}