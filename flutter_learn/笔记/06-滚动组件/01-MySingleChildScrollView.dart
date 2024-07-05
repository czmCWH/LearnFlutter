/*
<https://api.flutter-io.cn/flutter/widgets/SingleChildScrollView-class.html>

---- 滚动框

👉 1、SingleChildScrollView
SingleChildScrollView 滚动单个 Widget 的框。

使用场景：
  当容器在一个轴（滚动方向）上变得太小时，使得该容器可以滚动。例如：小屏、切换至横屏
  用于在两个轴上进行缩放，就像在对话框或弹出菜单中看到的那样。在这种情况下，将 SingleChildScrollView 与 ListBody 子项配对。

primary属性：
  它表示是否使用 widget 树中默认的 PrimaryScrollController（MaterialApp 组件树中已经默认包含一个 PrimaryScrollController 了）
  当滑动方向为垂直方向（scrollDirection值为Axis.vertical）并且没有指定 controller 时，primary 默认为 true。

 */

import 'package:flutter/material.dart';

class MySingleChildScrollView extends StatefulWidget {

  const MySingleChildScrollView({ super.key});

  @override
  State<MySingleChildScrollView> createState() {
    return _MySingleChildScrollView();
  }
}

class _MySingleChildScrollView extends State<MySingleChildScrollView> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SingleChildScrollView 滚动框'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,   // 滑动方向
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: List.generate(6, (index) {
            return Container(
              height: 50*(index + 1),
              color: Colors.primaries[index % Colors.primaries.length],
            );
          }).toList(),
        ),
      ),
    );
  }
}
