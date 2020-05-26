import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget loadingWidget() {
  return Container(
    width: ScreenUtil.screenWidth,
    height: ScreenUtil.screenHeight,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
