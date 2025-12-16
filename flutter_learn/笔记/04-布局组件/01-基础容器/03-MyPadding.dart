/*
<https://api.flutter-io.cn/flutter/widgets/Padding-class.html>

👉 1、Padding
为其子 Widget 添加内边距。
当将布局约束传递给子元素时，内边距会将约束缩小给定的内边距，从而使子元素以较小的尺寸布局。

  - padding 属性，EdgeInsetsGeometry是一个抽象类，一般都使用 EdgeInsets 类。
  - Container 组件也有 padding 属性，可以达到一样的效果。对于单一需求用 Padding 组件，复杂样式用 Container 组件。

 */
import 'package:flutter/material.dart';

class MyPadding extends StatelessWidget {
  const MyPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Padding 内边距组件'),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.amber,
            width: 100,
            height: 100,
            child: Padding(
              // 1、指定四个方向相同的内边距
              padding: const EdgeInsets.all(25),
              child: Container(color: Colors.red),
            ),
          ),
          Container(
            color: Colors.green[200],
            width: 100,
            height: 100,
            child: Padding(
              // 2、单独设置上边、左边内边距
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: Container(color: Colors.red),
            ),
          ),
          Container(
            color: Colors.blue[200],
            width: 100,
            height: 100,
            child: Padding(
              // 3、指定上下的内边距
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Container(color: Colors.red),
            ),
          ),
          Container(
            color: Colors.blue[200],
            width: 100,
            height: 100,
            child: Padding(
              // 4、指定四个方向不同的内边距
              padding: const EdgeInsets.fromLTRB(10, 20, 30, 40),
              child: Container(color: Colors.red),
            ),
          ),
        ],
      )

    );
  }
}