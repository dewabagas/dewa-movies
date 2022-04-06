import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared.dart';

class FilledButton extends StatelessWidget {
  final String text;
  final Widget? child;
  final double? width;
  final Color? color;
  final double height;
  final double? fontSize;
  final double borderRadius;
  final Function? onPressed;
  final bool disabled;

  const FilledButton({
    Key? key,
    this.text = "",
    this.child,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
    this.color,
    this.borderRadius = 15.0,
    this.fontSize = 16,
    this.disabled = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed as void Function()?,
          child: Center(
            child: text != ""
                ? Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize ?? 16.sp,
                        fontFamily: "AvenirMedium"),
                  )
                : child,
          ),
        ),
      ),
    );
  }
}
