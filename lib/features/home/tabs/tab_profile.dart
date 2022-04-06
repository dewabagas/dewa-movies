import 'package:dewa_movies/controllers/controller_configuration.dart';
import 'package:dewa_movies/features/home/controllers/controller_movie_results.dart';
import 'package:dewa_movies/shared/constants/strings.dart';
import 'package:dewa_movies/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TabProfile extends StatelessWidget {
  final _configurationController = Get.find<ControllerConfiguration>();
  final _resultsController = Get.find<ControllerMovieResults>();

  TabProfile({Key? key}) : super(key: key);

  Widget getItem(String name, String icon) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 16),
                  SvgPicture.asset(icon,
                      width: 20,
                      height: 20,
                      color: ColorConstants.appBackgroundDarker),
                  SizedBox(width: 16),
                  Text(
                    name,
                    style: TextStyle(
                        color: ColorConstants.appBackgroundDarker,
                        fontFamily: "AvenirBook",
                        fontSize: 16.sp),
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.keyboard_arrow_right, color: ColorConstants.appBackgroundDarker,),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Divider(
            color: hexToColor('#7f8c8d'),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      Assets.background,
                      height: height * 0.3,
                      fit: BoxFit.fill,
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: height * 0.225),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(width: 20.w),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white),
                              child: CircleAvatar(
                                  backgroundImage: AssetImage(Assets.iconBagas),
                                  radius: width * 0.15),
                            ),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Bagas Dewanggono",
                                    style: TextStyle(
                                        color:
                                            ColorConstants.appBackgroundDarker,
                                        fontSize: 18.sp,
                                        fontFamily: "AvenirBlack")),
                                Text("Mobile Application Developer",
                                    style: TextStyle(
                                        color:
                                            ColorConstants.appBackgroundDarker,
                                        fontSize: 14.sp,
                                        fontFamily: "AvenirMedium"))
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 24.h),
                        getItem("Profile", Svgs.iconUser),
                        getItem("Your Watchlist", Svgs.iconPlay),
                        getItem("Setting", Svgs.iconSetting),
                        getItem("About", Svgs.iconFile),
                        getItem("Quit", Svgs.iconLogout),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
