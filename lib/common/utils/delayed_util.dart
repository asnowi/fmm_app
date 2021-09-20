import 'dart:ui';

class DelayedUtil{

  /// 延时执行   // 使用: DelayedUtil.delayed(3000, () { });
  static delayed(VoidCallback voidCallback,{int milliseconds = 2000}){
    // 延时milliseconds执行返回
    Future.delayed(Duration(milliseconds: milliseconds),voidCallback);
  }
}