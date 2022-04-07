import 'package:dewa_movies/routes/routes.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerSplash extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(Duration(milliseconds: 2000));
    Get.toNamed(Routes.INTRO);
  }
}
