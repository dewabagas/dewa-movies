import 'package:dewa_movies/routes/routes.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerSplash extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(Duration(milliseconds: 2000));
    var storage = Get.find<SharedPreferences>();
    try {
      if (storage.getString(StorageConstants.token) != null) {
        Get.toNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.INTRO);
      }
    } catch (e) {
      Get.toNamed(Routes.INTRO);
    }
  }
}
