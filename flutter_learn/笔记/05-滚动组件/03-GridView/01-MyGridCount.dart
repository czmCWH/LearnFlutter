/*
<https://api.flutter-io.cn/flutter/widgets/BoxScrollView-class.html>

---- 网格布局

👉 1、GridView
GridView 是 一个可滚动的网格布局组件。GridView 的主轴方向是它滚动的方向。

GridView 默认构造器非常繁琐，常用构造器：
  GridView.count，基于交叉轴上固定数量来创建网格布局；
  GridView.extent，基于子项最大宽度/高度来创建网格布局；
  GridView.builder，创建具有大量（或无限）子元素的网格布局，并且需要接收 gridDelegate 布局委托属性，取值为：
    SliverGridDelegateWithFixedCrossAxisCount，固定列数 mainAxisSpacing 主轴间距；
    SliverGridDelegateWithMaxCrossAxisExtent，最大宽度 crossAxisSpacing 交叉轴间距；

GridView 基本上是一个 CustomScrollView，其 CustomScrollView.slives 属性中只有一个 SliverGrid。


 */

import 'package:flutter/material.dart';

// --- GridView.count 根据交叉轴固定个数来排列子项

class MyGridCount extends StatelessWidget {
  const MyGridCount({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.vertical,   // 设置滚动方向，默认垂直方向滚动
      primary: false,   // 是否是与父 PrimaryScrollController 关联的主滚动视图。
      physics: const BouncingScrollPhysics(),   // 网格组件滚动的物理特性，比如：首位弹簧回缩、不允许滚动范围不超过边界等等
      padding: const EdgeInsets.all(10),    // GridView 自身的内边距
      crossAxisCount: 3,      // ⚠️ 必要参数，次轴上显示 item 的个数。例如：垂直滚动时，每行3个。Flutter会自动计算次轴方向子项的大小，并均匀排列。
      mainAxisSpacing: 10,   // 主轴方向的间距
      crossAxisSpacing: 20,   // 交叉轴方向的间距
      childAspectRatio: 2/1,    // 子纵横比，决定每个item的size。例如：2/1，表示宽度是高度的2倍
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,    // 滑动时键盘消失
      children: List.generate(100, (int index) {
        return Container(
          color: Colors.amber,
          child: Center(
            child: Text("第$index个", style: const TextStyle(color: Colors.white, fontSize: 20),),
          ),
        );
      }),
    );
  }
}