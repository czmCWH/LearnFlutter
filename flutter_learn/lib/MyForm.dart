/*
Input widgets <https://docs.flutter.cn/ui/widgets/input>
 
 */

import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  // 定义常量构造函数
  const MyForm({
    Key? key,
    this.color = const Color(0x12000FE2),
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  // 存储可变状态
  @override
  State<MyForm> createState() {
    return _MyForm();
  }
}

class _MyForm extends State<MyForm> {
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
