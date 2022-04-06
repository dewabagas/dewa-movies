import 'package:get/get.dart';

enum ViewState { idle, retrived, busy, error }

class ControllerBase extends GetxController {
  final _state = ViewState.idle.obs;

  ViewState get state => _state.value;

  void setState(ViewState newState) {
    _state.value = newState;
  }
}
