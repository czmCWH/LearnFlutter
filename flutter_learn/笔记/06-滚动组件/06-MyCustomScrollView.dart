/*
<https://docs.flutter.cn/ui/widgets/scrolling>
<https://api.flutter-io.cn/flutter/widgets/CustomScrollView-class.html>
<https://api.flutter-io.cn/flutter/widgets/CustomScrollView/slivers.html>

---- 使用 slivers 创建自定义滚动

ListView、GridView、PageView 都是一个完整的可滚动组件，所谓完整是指它们都有自己的 Scrollable 、 Viewport 和 Sliver，因此它们只会响应自己可视区域的滚动。
CustomScrollView 组件来帮助我们创建一个公共的 Scrollable 和 Viewport ，然后它的 slivers 参数接受一个 Sliver 数组，这样就可以让这滚动组件共同响应滚动。

👉 1、CustomScrollView
CustomScrollView 使用 slivers 创建自定义滚动效果的 ScrollView。即 CustomScrollView 将多个子布局模型组合成一个滚动视图。
CustomScrollView 使用提供的 slivers 来创建各种滚动效果。例如创建三个 slivers 的列表：SliverAppBar、SliverList 和 SliverGrid。

CustomScrollView 注意点：
  slivers widgets 必须都是 RenderSliv​​er 对象。
  当 slivers widgets 中某个子项是完整的可滚动组件，且滚动方向和 CustomScrollView 一致，则该子项不会整合到 CustomScrollView 中一起滚动，而是单独滚动。


👉 2、Sliver
sliver 是由 RenderSliv​​er 子类支持的 Widget。

Slivers 与 RenderBox 子类支持的小部件不同，RenderBox个子类分别使用 BoxConstraints 和 Size，称为 box widget。(Container、Row和SizedBox等小部件都是长方体小部件。)
RenderBox 更加简单（实现简单的二维笛卡尔布局系统），但 Slivers 功能更加强大，并且针对单轴滚动环境进行了优化。
Slivers 托管在 viewports 中，也称为滚动视图，最著名的是 CustomScrollView。

Flutter 有许多内置的 sliver，并与滚动的 RenderBox 相对应，比如：
  SliverList

👉 3、SliverToBoxAdapter

SliverToBoxAdapter 用于包装 单个 box widget 的 sliver。
SliverToBoxAdapter 组件，它是一个适配器：可以将 RenderBox 适配为 Sliver。
通常不使用该组件，而是直接使用 Sliver。

 */


import 'package:flutter/material.dart';

class MyCustomScrollView extends StatefulWidget {
  // 定义常量构造函数
  const MyCustomScrollView({
    Key? key,
    this.color = const Color(0x12000FE2),
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  // 存储可变状态
  @override
  State<MyCustomScrollView> createState() {
    return _MyCustomScrollView();
  }
}

class _MyCustomScrollView extends State<MyCustomScrollView> {

  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomScrollView 使用 slivers 创建自定义滚动'),
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,   // 滚动方向
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Demo'),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('Grid Item $index'),
                );
              },
              childCount: 20,
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('List Item $index'),
                );
              },
              childCount: 10,
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: PageView(
                scrollDirection: Axis.vertical,   // 此时 完整的 PageView 不会整合到 CustomScrollView 中一起滚动。
                children: const [Text("1"), Text("2")],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
