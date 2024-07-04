/*

---- 填充子项

👉 1、Padding
通过给定的填充（留白）来插入它的子部件。

 EdgeInsetsGeometry padding：EdgeInsetsGeometry是一个抽象类，一般都使用 EdgeInsets 类。

 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyPadding extends StatelessWidget {
  const MyPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Padding 填充组件'),
      ),
      body:  Padding(
        //上下左右各添加16像素补白
        padding: const EdgeInsets.all(16),
        child: Column(
          //显式指定对齐方式为左对齐，排除对齐干扰
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              //左边添加8像素补白
              padding: const EdgeInsets.only(left: 8),
              child: Container(color: Colors.orange, height: 50),
            ),
            Padding(
              //上下各添加8像素补白
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(color: Colors.orange, height: 50),
            ),
            Padding(
              // 分别指定四个方向的补白
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Container(color: Colors.orange, height: 50),
            )
          ],
        ),
      ),
    );
  }
}
