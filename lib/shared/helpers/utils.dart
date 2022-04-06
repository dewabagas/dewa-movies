import 'package:flutter/material.dart';
import 'package:get/get.dart';

dismisKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String parseErrorMessage(String? s) {
  if (s == null) {
    return "wentWrong".tr;
  } else if (s.toLowerCase().contains("connection")) {
    return "connectionFailed".tr;
  } else {
    return "connectionFailed".tr;
  }
}
