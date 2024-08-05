/*
<https://api.flutter-io.cn/flutter/widgets/RawGestureDetector-class.html>

---- 检测指定的手势

// 未完成 

👉 1、RawGestureDetector

RawGestureDetector 检测给定手势的 Widget。常用于自定义手势


 */

import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyRawGestureDetector(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyRawGestureDetector extends StatefulWidget {
  // 定义常量构造函数
  const MyRawGestureDetector({ Key? key }) : super(key: key);

  // 存储可变状态
  @override
  State<MyRawGestureDetector> createState() {
    return _MyRawGestureDetector();
  }
}

class _MyRawGestureDetector extends State<MyRawGestureDetector> {
  
  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: const Center(
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
