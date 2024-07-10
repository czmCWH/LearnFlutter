/*
<https://docs.flutter.cn/ui/widgets/material2>
<https://docs.flutter.cn/ui/layout>
<https://api.flutter-io.cn/flutter/material/Scaffold-class.html>

--- Material 2 页面骨架 Scaffold

对于 Material app，你可以使用 Scaffold widget，它提供默认的 banner 背景颜色，
还有用于添加抽屉(drawers)、提示条(snack bars) 和 底部列表弹窗(bottom sheets) 的 API。

 👉 1、 Scaffold






 */


import 'package:flutter/material.dart';

class MyScaffold extends StatefulWidget {
  // 定义常量构造函数
  const MyScaffold({
    Key? key,
    this.color = const Color(0x12000FE2),
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  // 存储可变状态
  @override
  State<MyScaffold> createState() {
    return _MyScaffold();
  }
}

class _MyScaffold extends State<MyScaffold> {
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
