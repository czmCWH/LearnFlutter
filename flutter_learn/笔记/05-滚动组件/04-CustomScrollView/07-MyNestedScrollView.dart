/*
<https://api.flutter.dev/flutter/widgets/NestedScrollView-class.html>
<https://ducafecat.com/blog/flutter-sliver-nested-scroll-view>

---- 嵌套滚动 Widgets

👉 1、NestedScrollView
NestedScrollView 是一个滚动视图，用于处理 嵌套滚动，协调父滚动视图和子滚动视图的滚动行为。

问题：
  在普通的 ScrollView中，有一组 slivers(即滚动组件)。如果其中一个 slivers 承载着一个以相反方向滚动的 TabBarView。
  （例如，允许用户在 tabs 表示的页面之间水平滑动，而列表垂直滚动），则该 TabBarView 内的任何列表都不会与外部 ScrollView 交互。
解决：
  NestedScrollView 通过为外部 ScrollView 和内部 ScrollView（TabBarView 内部的 ScrollView）提供自定义 ScrollController 来解决此问题，
  将它们连接在一起，以便在用户看来，它们是一个连贯的滚动视图。


*/
import 'package:flutter/material.dart';

class MyNestedScrollView extends StatefulWidget {
  // 定义常量构造函数
  const MyNestedScrollView({ super.key });

  // 存储可变状态
  @override
  State<MyNestedScrollView> createState() {
    return _MyNestedScrollView();
  }
}

class _MyNestedScrollView extends State<MyNestedScrollView> {
  

  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NestedScrollView'),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // 返回一个 Sliver 数组给外部可滚动组件。
          return <Widget>[
            SliverAppBar(
              title: const Text('嵌套ListView'),
              pinned: true, // 固定在顶部
              forceElevated: innerBoxIsScrolled,
            ),
            buildSliverList(5), //构建一个 sliverList
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          physics: const ClampingScrollPhysics(), //重要
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(child: Text('Item $index')),
            );
          },
        ),
      ),
    );
  }

  // 构建固定高度的SliverList，count为列表项属相
  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(title: Text('$index'));
        },
        childCount: count,
      ),
    );
  }
  
}
