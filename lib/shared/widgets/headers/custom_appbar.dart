import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../shared.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget? icon;
  final Widget? center;
  final Widget? bottom;
  final Widget? flexibleSpace;

  final Color? color;
  final Color? colorTitle;
  final Widget? leadingIcon;
  final List<Widget>? actions;
  final double elevation;
  final Function()? onBackPressed;
  final bool useLeading;
  const CustomAppBar(
      {Key? key,
      this.leadingIcon,
      required this.title,
      this.color,
      this.colorTitle,
      this.icon,
      this.center,
      this.bottom,
      this.flexibleSpace,
      this.actions,
      this.elevation = 0,
      this.onBackPressed,
      this.useLeading = false})
      : super(key: key);

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      elevation: widget.elevation,
      backgroundColor: widget.color ?? Colors.transparent,
      leading: widget.useLeading
          ? widget.leadingIcon ??
              IconButton(
                  padding: EdgeInsets.only(left: 28.w),
                  icon: Icon(
                    Icons.arrow_back,
                    color: widget.colorTitle ?? ColorConstants.lightGray,
                    size: 24.w,
                  ),
                  onPressed: widget.onBackPressed ?? () => Get.back())
          : null,
      title: Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: widget.center ??
            Text(
              widget.title,
              style: TextStyles.listHeader.copyWith(fontWeight: FontWeight.w600),
            ),
      ),
      actions: widget.actions ??
          <Widget>[
            Padding(
              padding: EdgeInsets.only(right: Insets.lg),
              child: GestureDetector(
                child: widget.icon ?? Container(),
              ),
            ),
          ],
      centerTitle: false,
    );
  }
}
