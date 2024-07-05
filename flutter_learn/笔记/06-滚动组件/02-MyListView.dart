/*
<https://docs.flutter.cn/ui/widgets/layout>
<https://api.flutter-io.cn/flutter/widgets/BoxScrollView-class.html>

---- 滚动列表

👉 1、ListView
ListView 线性排列 Widget 的可滚动的列表。

ListView 是最常用的滚动小部件。它在滚动方向上一个接一个地显示其子项。在交叉轴中，需要子项来填充ListView。
itemExtent 表示 ListView在滚动方向上每个item所占的高度值。
prototypeItem 将强制子项在滚动方向上具有与其 prototypeItem 给定 Widget 相同的大小。

指定 itemExtent 或 prototypeItem 比让 children 确定自己的范围更有效，因为滚动机制可以利用 children 范围的预知来节省工作。例如当滚动位置急剧变化时。
不能同时指定 itemExtent 和 prototypeItem，只能指定其中一个 或 都不指定。

构建 ListView 有四个构造函数选项：

要控制滚动视图的初始滚动偏移，提供一个具有 ScrollController.initialScrollOffset 属性集的 controller。
默认情况下，ListView将自动填充列表的可滚动末端，以避免 MediaQuery 的填充所指示的部分障碍。若要避免这种行为，请使用 padding zero 属性进行覆盖。

 */

import 'package:flutter/material.dart';

class MyListView extends StatefulWidget {
  // 定义常量构造函数
  const MyListView({ super.key });

  // 存储可变状态
  @override
  State<MyListView> createState() {
    // return _MyListView1();
    // return _MyListView2();
    // return _MyListView3();
    return _MyListView4();
  }
}


/*
1、默认构造函数采用 children 的显式 List＜Widget＞。
适用于具有少量子级的 ListView，因为构造 List 需要为 ListView 中可能显示的每个子级（而不仅仅是那些实际可见的子级）执行工作。
 */
class _MyListView1 extends State<MyListView> {

  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView 默认构造函数'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,   // 滚动方向
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20), // 列表内边距
        reverse: false,    // 是否颠倒list view子项的排列方向。
        physics: const ClampingScrollPhysics(),   // list view滚动的行为，例如：不允许滚动、弹簧式滚动、无偏移式滚动。
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,    // 滑动时关闭键盘
        // itemExtent: 80,   // 强制设置每个子项item在滚动方向的范围（宽度或高度）为80
        prototypeItem: Container(color: Colors.red, height: 100,),   // 强制子项item的范围与prototypeItem一样
        children: [
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('第一行'),),
          ),
          Container(
            height: 50,
            color: Colors.amber[300],
            child: const Center(child: Text('第二行'),),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('第三行'),),
          ),
        ],
      ),

    );
  }
}

/*
2、ListView.builder 接收一个 IndexedWidgetBuilder，它根据需要构建子元素。
此构造函数适用于具有大量（或无限）子级的列表视图，因为该构造函数仅针对那些实际可见的子级调用。
 */
class _MyListView2 extends State<MyListView> {

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView.builder 构造函数'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            height: 80,
            color: Colors.amber[colorCodes[index]],
            child: Center(child: Text("类型 -- ${entries[index]}"),),
          );
        },
      ),
    );
  }
}

/*
3、ListView.separated 接收两个 IndexedWidgetBuilder
itemBuilder 根据需要生成子项，separatorBuilder 类似地生成出现在子项之间的分隔符子项。
此构造函数适用于具有固定数量子级的列表视图。
 */
class _MyListView3 extends State<MyListView> {

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView.separated 构造函数'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 80,
            color: Colors.amber,
            child: Center(child: Text('第 $index 行'),),
          );
        },
        separatorBuilder: (BuildContext context, int index)  => const Divider(),    // 子项之间分割子项
        itemCount: 10
      ),
    );
  }
}

/*
4、ListView.custom 接受一个 SliverChildDelegate，它提供了自定义子模型的其他方面的能力。
例如，SliverChildDelegate 可以控制用于估计实际不可见的子级大小的算法。
 */
class _MyListView4 extends State<MyListView> {

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView 滚动列表'),
      ),
      body: ListView.custom(
        childrenDelegate: SliverChildListDelegate(
          const [_ListItem(title: "0"), _ListItem(title: "1"),],
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;

  const _ListItem({Key? key, required this.title}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        alignment: Alignment.center,
        child: Text('内容：$title'),
      ),
    );
  }
}