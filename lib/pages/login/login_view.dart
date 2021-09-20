import 'package:flutter/material.dart';
import 'package:fmm_app/pages/login/login_controller.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController>{
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,// 解决键盘顶起页面
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Text('title'.tr),
    );
  }

}