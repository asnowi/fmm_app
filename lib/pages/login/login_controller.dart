import 'package:fmm_app/common/app/index.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class LoginController extends GetxController{


  // 声明视频控制器
  late VideoPlayerController _videoPlayerController;

  @override
  void onInit() {
    _videoPlayerController = VideoPlayerController.network(AppConfig.VIDEO_URL);
    super.onInit();
  }
}