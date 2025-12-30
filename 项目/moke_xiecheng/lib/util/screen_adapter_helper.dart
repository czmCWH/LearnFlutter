import 'package:flutter/material.dart';

/// 扩展 int 类型，方便屏幕适配
extension IntFit on int {
  /// eg: 100.px
  double get px {
    return ScreenHelper.getPx(toDouble());
  }
}

/// 扩展 double 类型，方便屏幕适配
extension DoubleFit on double {
  /// eg: 200.0.px
  double get px {
    return ScreenHelper.getPx(this);
  }
}

/// 屏幕适配工具类，如果UI要求和UI稿完全一致还原度时使用
class ScreenHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double ratio;

  /// 根据设计稿的宽度初始化
  /// baseWidth 是设计稿的宽度
  static init(BuildContext context, {double baseWidth = 375}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    ratio = screenWidth/baseWidth;
  }

  /// 获取设计稿对应的大小
  static double getPx(double size) {
    return ScreenHelper.ratio * size;
  }

}


/*
适配测试：
Column(
  children: [
    Container(
      color: Colors.blue,
      width: 200,
      height: 200,
      child: const Text('没有适配大小'),
    ),
    Container(
      color: Colors.blue,
      width: 200.px,
      height: 200.px,
      child: const Text('适配后的大小，在大屏上比原来的大'),
    ),
  ],
),
*/