import 'package:fmm_app/common/app/index.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class LoginController extends GetxController{


  // 声明视频控制器
  late VideoPlayerController videoPlayerController;

  @override
  void onInit() {
    videoPlayerController = VideoPlayerController.network(AppConfig.VIDEO_URL);
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