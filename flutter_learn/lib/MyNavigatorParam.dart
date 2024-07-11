/*
<https://api.flutter-io.cn/flutter/widgets/Navigator-class.html>

------ Navigator 跳转参数

 
 */
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyNavigatorParam(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyNavigatorParam extends StatefulWidget {
  // 定义常量构造函数
  const MyNavigatorParam({ super.key });

  // 存储可变状态
  @override
  State<MyNavigatorParam> createState() {
    return _MyNavigatorParam();
  }
}

class _MyNavigatorParam extends State<MyNavigatorParam> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: const  Text('123')
    );
  }
}
