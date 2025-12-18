/*
<https://api.flutter-io.cn/flutter/widgets/BoxScrollView-class.html>

---- 网格布局

👉 1、GridView
GridView 是 一个可滚动的2D小部件数组。GridView 的主轴方向是它滚动的方向。

要控制滚动视图的初始滚动偏移，请提供一个 controller，并设置其 ScrollController.initialScrollOffset 属性。

👉 2、过渡到 CustomScrollView

GridView 基本上是一个 CustomScrollView，其 CustomScrollView.slives 属性中只有一个 SliverGrid。
如果 GridView 不再足够，例如因为滚动视图要同时具有 Grid 和 List，或者因为 Grid 要与 SliverAppBar 组合等，则直接将代码从使用 GridView 移植到直接使用 CustomScrollView。
GridView上的 key、scrollDirection、reverse、controller、primary、physics 和 shrinkWrap 属性直接映射到 CustomScrollView 上的同名属性。

 */

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class MyGridView extends StatefulWidget {

  const MyGridView({ super.key });

  @override
  State<MyGridView> createState() {
    // return _MyGridView1();
    // return _MyGridView2();
    return _MyGridView3();
  }
}

/*
1、GridView.count 创建一个在横轴上具有固定数量的 tiles 的布局。
 */
class _MyGridView1 extends State<MyGridView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView.count 构造函数'),
      ),
      body: GridView.count(
        scrollDirection: Axis.vertical,   // 设置滚动方向，默认垂直方向滚动
        primary: false,   // 是否是与父 PrimaryScrollController 关联的主滚动视图。
        physics: const BouncingScrollPhysics(),   // 网格组件滚动的物理特性，比如：首位弹簧回缩、不允许滚动范围不超过边界等等
        padding: const EdgeInsets.all(30),    // GridView 自身的内边距
        crossAxisCount: 3,      // 必要参数，次轴上显示 item 的个数。例如：垂直滚动时，每行3个。
        mainAxisSpacing: 10,   // 主轴方向的间距
        crossAxisSpacing: 15,   // 次轴方向的间距
        childAspectRatio: 2/1,    // 子纵横比，决定每个item的size。例如：2/1，表示宽度是高度的2倍
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,    // 滑动时键盘消失
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

/*
2、GridView.extent 创建子项在次轴方向上有固定最大长度的布局。
 */
class _MyGridView2 extends State<MyGridView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView.count 构造函数'),
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 414/3,      // 必要参数，表示次轴上每个元素的最大长度。因为次轴方向每个子元素的长度仍然是等分的。
        mainAxisSpacing: 10,
        crossAxisSpacing: 15,
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
        ],
      ),
    );
  }
}


/*
3、GridView.builder 用于创建具有大量（或无限）子级的 Grid。
required SliverGridDelegate gridDelegate 控制子项的布局，其的子类可为：
  SliverGridDelegateWithFixedCrossAxisCount  创建次轴上有固定数量子项的。
  SliverGridDeegateWithMaxCrossAxisExtent 根据子项在次轴方向上最大大小来布局子项。
 */
class _MyGridView3 extends State<MyGridView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView.count 构造函数'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 次轴上item固定数量4
          childAspectRatio: 1 / 2, // 子项宽高比为1:2
          crossAxisSpacing: 10, // 次轴间距
          mainAxisSpacing: 15,  // 主轴间距
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue[100 * (index + 1)],
            child: Text('第$index个'),
          );
        },
        itemCount: 9, // 子项的个数
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}

/*
 4、GridView.custom 要使用自定义 SliverChildDelegate。
 自定义 SliverGridDelegate 可以生成子项的任意二维排列，包括未对齐或重叠的排列。
 */