import 'package:flutter/material.dart';
import 'package:fmm_app/common/app/index.dart';
import 'package:fmm_app/common/db/index.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class LoginController extends GetxController{


  bool _isAgree = true;
  bool get isAgree => _isAgree;
  void setAgree(value) {
    _isAgree = value;
    update(['agree']);
    setLogin();
  }

  // 声明视频控制器
  late VideoPlayerController videoPlayerController;

  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isAccount = false;
  bool get account => _isAccount;
  void setAccount(value) {
    _isAccount = value;
    update(['account']);
    setLogin();
  }

  bool _isPassword = false;
  bool get password => _isPassword;
  void setPassword(value) {
    _isPassword = value;
    update(['password']);
    setLogin();
  }

  bool _isEye = true;
  bool get eye => _isEye;
  void setEye() {
    _isEye = !_isEye;
    update(['password']);
    setLogin();
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;
  void setLogin(){
    _isLogin = _isAgree && _isAccount && _isPassword;
    update(['login']);
  }

  void onLogin () async{
    final User user = User('userId001', accountController.text, 'tokenxx', 'http://p1.music.126.net/GE2kVDwdVQyoNJC8k31mEA==/18979769718754963.jpg');
    int result = await Global.dbUtil.saveUser(user);
    Logger.ggq('-----saveUser----->>${result}');
    if(result >= 0) {
      Get.back( result: true );
    }else {
      ToastUtil.show('登录失败！');
    }
  }
  @override
  void onInit() {
    // videoPlayerController = VideoPlayerController.network(AppConfig.VIDEO_URL);
    videoPlayerController = VideoPlayerController.asset(AssetsProvider.loadVideo('video-login-hd'));
    super.onInit();
  }

  @override
  void onReady() {
    videoPlayerController.initialize().then((value){
      update(['player']);
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
    });
    super.onReady();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

}