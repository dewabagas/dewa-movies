import 'dart:math';

import 'package:dewa_movies/features/home/home.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerHome extends GetxController {

  var currentTab = MainTabs.movies.obs;

  late TabMovies tabMovies;
  late TabTvSeries tabTvSeries;
  late TabProfile tabProfile;

  @override
  void onInit() async {
    super.onInit();

    tabMovies = TabMovies();
    tabTvSeries = TabTvSeries();
    tabProfile = TabProfile();
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(MainTabs tab) {
    switch (tab) {
      case MainTabs.movies:
        return 0;
      case MainTabs.tv:
        return 1;
      case MainTabs.profile:
        return 2;
      default:
        return 0;
    }
  }

  MainTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return MainTabs.movies;
      case 1:
        return MainTabs.tv;
      case 2:
        return MainTabs.profile;
      default:
        return MainTabs.movies;
    }
  }
}
