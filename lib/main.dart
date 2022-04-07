import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dewa_movies/shared/helpers/utils.dart';


import 'app_binding.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  setUp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        initialRoute: Routes.SPLASH,
        defaultTransition: Transition.fade,
        getPages: AppPages.routes,
        initialBinding: AppBinding(),
        smartManagement: SmartManagement.keepFactory,
        title: 'Dewa Movies',
        theme: ThemeConfig.lightTheme,
        builder: (context, Widget? child) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                dismisKeyboard();
              },
              child: child
            ),
          );
        },
      ),
    );
  }
}

