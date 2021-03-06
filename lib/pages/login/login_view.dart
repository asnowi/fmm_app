import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fmm_app/common/utils/index.dart';
import 'package:fmm_app/common/values/index.dart';
import 'package:fmm_app/pages/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class LoginView extends GetView<LoginController>{
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          _buildPlayer(context),
          _buildAction(),
          _buildContent(),
          _buildAgreement()
        ],
      )
    );
  }


  /// 使用Transform.scale对视频进行缩放，
  /// 我们想要的效果就是不管视频是什么比率，
  /// 都可以平铺无拉伸的显示。Center让视频放大以后居中显示，
  /// 缩放比为_controller.value.aspectRatio /MediaQuery.of(context).size.aspectRatio，
  /// 用视频的宽高比除以设备的宽高比。
  Widget _buildPlayer(BuildContext context) {
    return GetBuilder<LoginController>(
      id: 'player',
      builder: (_) => Transform.scale(
        scale: controller.videoPlayerController.value.aspectRatio / MediaQuery.of(context).size.aspectRatio * 1.01,
        child: Center(
          child: Container(
            child: controller.videoPlayerController.value.isInitialized ?
            AspectRatio(aspectRatio: controller.videoPlayerController.value.aspectRatio,child: VideoPlayer(controller.videoPlayerController)): Container(
              color: Colors.white,
              width: 42,
              height: 42,
              child: Lottie.asset(AssetsProvider.lottiePath('loading')),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAction() {
    return Positioned(
      top: 20.h,
      left: 10.w,
      child: IconButton(
        onPressed: () {
          Get.back();
        },
        splashRadius: AppDimens.backRadius,
        icon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      )
    );
  }
  Widget _buildAgreement(){
    return Positioned(
      bottom: 10.h,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: InkWell(
                child: GetBuilder<LoginController>(
                  id: 'agree',
                  builder: (_) => controller.isAgree? const Icon(Icons.radio_button_on,size: 18,color: Colors.redAccent,): const Icon(Icons.radio_button_on,size: 18,color: Colors.grey,),
                ),
                onTap: (){
                  controller.setAgree(!controller.isAgree);
                },
                splashColor: Colors.blue[50],
                focusColor: Colors.blue[50],
                highlightColor: Colors.blue[50],
              ),
            ),

            RichText(
              text: TextSpan(
                  text: '我已认真阅读并同意',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                  children: [
                    TextSpan(
                        text: '《用户使用协议》',
                        style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer() ..onTap = () {
                          ToastUtil.show('用户使用协议');
                        }
                    ),
                    const TextSpan(
                        text: '及',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontStyle: FontStyle.italic)),
                    TextSpan(
                        text: '《隐私条款》',
                        style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer() ..onTap = () {
                          ToastUtil.show('隐私条款');
                        }
                    ),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildContent(){
    return GetBuilder<LoginController>(
      id: 'player',
      builder: (_) => controller.videoPlayerController.value.isInitialized? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInputAccount(),
            SizedBox(height: 20.h),
            _buildInputPassword(),
            SizedBox(height: 20.h),
            _buildLogin()
          ],
        ),
      ): Container()
    );
  }
  Widget _buildInputAccount(){
    const String _phone = '13717591366';
    if(!StringUtils.isEmpty(_phone)){
      controller.accountController.text = _phone;
      controller.setAccount(controller.accountController.text.isNotEmpty);
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 48.h,
          maxWidth: 0.82.sw
      ),
      child: GetBuilder<LoginController>(
          id: 'account',
          builder: (_) => TextField(
            controller: controller.accountController,
            maxLines: 1,
            autocorrect: true,//是否自动更正
            // autofocus: true,//是否自动对焦
            textAlign: TextAlign.start,//文本对齐方式
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              hintText: '请输入手机号',
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              prefixIcon: const Icon(Iconfont.phone,color: Colors.redAccent,size: 16),
              suffixIcon: controller.account? IconButton(icon: const Icon(Iconfont.close,color: Colors.redAccent, size: 16), onPressed: (){
                controller.accountController.clear();
                controller.setAccount(false);
              }):null,
              // contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.white60,
            ),
            onChanged: (text) {//内容改变的回调
              Logger.ggq('-----账号------>>${text}');
              controller.setAccount(text.isNotEmpty);
            },
            onSubmitted: (text) {//内容提交(按回车)的回调
              Logger.ggq('phone onSubmitted:${text}');
            },
          )
      ),
    );
  }
  Widget _buildInputPassword(){
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 48.h,
          maxWidth: 0.82.sw
      ),
      child: GetBuilder<LoginController>(
        id: 'password',
        builder: (_) => TextField(
          controller: controller.passwordController,
          maxLines: 1,
          autocorrect: true,//是否自动更正
          // autofocus: true,//是否自动对焦
          textAlign: TextAlign.start,//文本对齐方式
          obscureText: controller.eye,//是否是密码
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 4),
            hintText: '请输入密码',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            prefixIcon: const Icon(Iconfont.pwd,color: Colors.redAccent,size: 16),
            suffixIcon: controller.password? IconButton(
                icon: controller.eye? const Icon(Iconfont.eyeHide,color: Colors.redAccent,size: 16): const Icon(Iconfont.eyeShow,color: Colors.redAccent,size: 16), onPressed: (){
              controller.setEye();
            }):null,
            // contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white60,
          ),
          onChanged: (text) {//内容改变的回调
            Logger.ggq('-----密码------>>${text}');
            controller.setPassword(text.isNotEmpty);
          },
          onSubmitted: (text) {//内容提交(按回车)的回调
            Logger.ggq('password onSubmitted:${text}');
          },
        ),
      ),
    );
  }
  Widget _buildLogin() {
    return Container(
      width: 0.82.sw ,
      child: GetBuilder<LoginController>(
        id: 'login',
        builder: (_) =>ElevatedButton(onPressed: controller.isLogin? (){
          if(!controller.isAgree){
            ToastUtil.show('请您认真阅读并同意《用户使用协议》及《隐私条款》');
            return;
          }
          if(!RegexUtils.isPhone(controller.accountController.text)){
            ToastUtil.show('您输入的手机号格式不正确');
            return;
          }
          controller.onLogin();
        }:null,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states){
                  if(states.contains(MaterialState.disabled)){
                    return Colors.red[100];
                  }
                  return Colors.redAccent;
                })
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: const Text('登录',style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
            )
        ),
      ),
    );
  }

}