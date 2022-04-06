import 'package:cached_network_image/cached_network_image.dart';
import 'package:dewa_movies/shared/constants/assets.dart';
import 'package:dewa_movies/shared/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppBarBuilder extends StatelessWidget {
  AppBarBuilder({this.height, this.padding, Key? key}) : super(key: key);

  // final void Function()? onSearchTap;
  final double? height;
  final EdgeInsetsGeometry? padding;

  // final _searchController = Get.find<SearchController>();
  // final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.fromLTRB(12, 0, 12, 0),
      // color: ColorConstants.appBackground,
      height: 66.h,
      child: Row(
        children: [
          // avatar profile
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 6),
          // ),
         Expanded(
            child: Image.asset(Assets.icon3dGlasses, height: 50.h,),
          ),
          // IconButton(
          //     onPressed: () {
          //       // _utilityController.resetSearchTabbarState();
          //       // _searchController.resetSearchState();
          //       Get.toNamed('/search');
          //       // print(Auth().isGuestLoggedIn
          //       //     ? Auth().guestSessionId
          //       //     : 'guest not logged in');

          //       // _accountController.getAccountDetails();

          //       // DownloadController().downloadFile(
          //       //     url:
          //       //         'https://img.youtube.com/vi/gmRKv7n2If8/hqdefault.jpg');
          //     },
          //     icon: Icon(
          //       Icons.search,
          //       size: 26,
          //       color: ColorConstants.appBackground,
          //     )),
        ],
      ),
    );
  }
}
