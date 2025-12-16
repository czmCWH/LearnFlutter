/*
 <https://api.flutter-io.cn/flutter/widgets/Wrap-class.html>

 👉 1、Wrap
 Wrap 以多个水平或垂直运行方式排列其子级的 Widget，当主轴方向排列不下时会自动换行（或换列）。

 应用场景：
    类似于搜索历史页面样式，一行一行摆放item，摆放不下就换行。

 */

import 'package:flutter/material.dart';

class MyWrap extends StatelessWidget {
  const MyWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[200],
      child: Wrap(
        // 设置主轴方向，即排列子 Widget 的方向。
        direction: Axis.horizontal,
        // 子组件在主轴方向上的对齐方式。如，在一行中剩余空间时，alignment 决定子项如何分布。
        alignment: WrapAlignment.start,
        // 主轴方向上，子组件之间的间隔
        spacing: 20,
        // 控制所有子 Widget 这个整体在交叉轴方向上的对齐方式
        runAlignment: WrapAlignment.center,
        // 交叉轴方向上的间距
        runSpacing: 40,
        // 子组件在交叉轴方向上的对齐方式
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          Container(color: Colors.red, width: 100, height: 100,),
          Container(color: Colors.lightGreen, width: 80, height: 80,),
          Container(color: Colors.lightBlue, width: 50, height: 50,),
          Container(color: Colors.purple[300], width: 120, height: 120,),
          // Container(color: Colors.red, width: 100, height: 100,),
          Container(color: Colors.lightGreen, width: 80, height: 80,),
          Container(color: Colors.lightBlue, width: 50, height: 50,),
          Container(color: Colors.purple[300], width: 120, height: 120,),
        ],
      ),
    );
  }
}
