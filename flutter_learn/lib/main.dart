import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'MyNotification.dart';

void main() {

  // debug 模式时，显示每个组件的大小
  debugPaintSizeEnabled = false;
  // 查看 GestureDetector 触摸框的大小。需要 import 'package:flutter/rendering.dart';
  debugPaintPointersEnabled = false;
  // 在 debug 模式下，每次调用手势识别器回调时都会记录一条消息。需要 import 'package:flutter/gestures.dart'; 
  debugPrintRecognizerCallbacksTrace = true;

  // runApp()函数接受给定的 Widget，并将其作为Widget树的根。
  runApp(const MainApp());
}
