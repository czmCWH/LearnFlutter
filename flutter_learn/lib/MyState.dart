/*
<https://docs.flutter.cn/data-and-backend/state-mgmt/intro>
<https://book.flutterchina.club/chapter2/state_manage.html#_2-3-1-%E7%AE%80%E4%BB%8B>
<https://juejin.cn/post/7306447634204999695#heading-1>

--- 状态管理

 */


import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyStatefulScaffold(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyStatefulScaffold extends StatefulWidget {
  // 定义常量构造函数
  const MyStatefulScaffold({
    Key? key,
    this.color = const Color(0x12000FE2),
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  // 存储可变状态
  @override
  State<MyStatefulScaffold> createState() {
    return _MyStatefulScaffold();
  }
}

class _MyStatefulScaffold extends State<MyStatefulScaffold> {
  double _size = 1.0;

  void grow() {
    setState(() {
      _size += 0.2;
    });
  }

  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: GestureDetector(
        onTap: grow,
        child: Container(
          color: widget.color,
          child: widget.child,
          transform: Matrix4.diagonal3Values(_size, _size, 1.0),
        ),
      ),
    );
  }
}
