import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared.dart';

class CustomHeader extends StatelessWidget {
  final String text;

  const CustomHeader({
    Key? key,
    this.text = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: 410.83.w,
            height: 228.88.h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/artworks/header.png'),
                    fit: BoxFit.fill)),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: "AvenirHeavy",
                    color: Colors.white),
              ))
        ],
      ),
    );
  }
}
