/*
<https://api.flutter-io.cn/flutter/widgets/GridView-class.html>

---- 网格布局

👉 1、GridView
GridView 是 一个可滚动的2D小部件数组。GridView 的主轴方向是它滚动的方向。

最常用的 GridView 布局有：
GridView.count 创建的布局在横轴上具有固定数量的 tiles。
GridView.extent 创建的布局具有最大横轴范围的 tiles。
自定义 SliverGridDelegate 可以生成子项的任意二维排列，包括未对齐或重叠的排列。

若要创建具有大量（或无限）子级的 Grid，请将 GridView.builder 构造函数与网格 Delegate 的 SliverGridDelegateWithFixedCrossAxisCount或SliverGridDeegateWithMaxCrossAxisExtent一起使用。
若要使用自定义SliverChildDelegate，请使用GridView.custom。
若要创建子项的线性数组，请使用ListView。
要控制滚动视图的初始滚动偏移，请为控制器提供其ScrollController.initialScrollOffset属性集。



 */

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class MyGridView extends StatefulWidget {

  const MyGridView({ super.key });

  @override
  State<MyGridView> createState() {
    return _MyGridView();
  }
}

class _MyGridView extends State<MyGridView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView 网格布局'),
      ),
      body: GridView.count(
        primary: false,
        crossAxisCount: 3,      // 必要参数，交叉轴上显示item的个数。例如：垂直滚动时，每行3个。
        scrollDirection: Axis.vertical,   // 设置滚动方向，垂直方向滚动
        physics: const BouncingScrollPhysics(),   // 网格组件滚动的物理特性，比如：首位弹簧回缩、不允许滚动范围不超过边界等等
        padding: const EdgeInsets.all(20),    // 网格组件内边距
        mainAxisSpacing: 10,   // 主轴方向的间距
        crossAxisSpacing: 15,   // 辅轴方向的间距
        childAspectRatio: 2/1,    // 子纵横比，决定每个item的size。例如：2/1，表示宽度是高度的2倍
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,    // 滑动时键盘消失
        dragStartBehavior: DragStartBehavior.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: const Text("第一个"),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[200],
            child: const Text('第二个'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[300],
            child: const Text('第三个'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[400],
            child: const Text('第四个'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[500],
            child: const Text('第五个'),
          ),
        ],
      ),
    );
  }
}
