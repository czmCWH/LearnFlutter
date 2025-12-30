import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 间距
SizedBox hiSpace( {double height = 1, double width = 1} ) {
  return SizedBox(height: height, width: width,);
}

/// 添加阴影
Widget shadowWrap({required Widget child, EdgeInsetsGeometry? padding}) {
  return Container(
    padding: padding,
    // AppBar 渐变遮罩背景
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0x66000000), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: child,
  );
}