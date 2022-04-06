import 'package:get/get.dart';
import 'controllers/controller_splash.dart';

class BindingSplash extends Bindings {
  @override
  void dependencies() {
    Get.put<ControllerSplash>(ControllerSplash());
  }
}
