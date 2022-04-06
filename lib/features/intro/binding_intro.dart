import 'package:get/get.dart';

import 'controllers/controller_intro.dart';

class BindingIntro implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerIntro>(
        () => ControllerIntro());
  }
}
