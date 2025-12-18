/*
<https://docs.flutter.cn/ui/widgets/scrolling>
<https://api.flutter-io.cn/flutter/widgets/CustomScrollView-class.html>
<https://api.flutter-io.cn/flutter/widgets/CustomScrollView/slivers.html>

ListView、GridView、PageView 都是一个完整的可滚动组件，即它们都有自己的 Scrollable、Viewport 和 Sliver，因此它们只会响应自己可视区域的滚动。

👉 1、CustomScrollView
CustomScrollView 组件创建一个公共的 Scrollable 和 Viewport，用于组合多个 Sliver 组件，实现统一协调的滚动效果。
  slivers 属性，接收 RenderSliv​​er 对象。

👉 2、Sliver
sliver 是由 RenderSliv​​er 子类支持的 Widget。

Slivers 与 RenderBox 子类支持的小部件不同，RenderBox 个子类分别使用 BoxConstraints 和 Size，称为 box widget。(Container、Row和SizedBox等小部件都是长方体小部件。)
RenderBox 更加简单（实现简单的二维笛卡尔布局系统），但 Slivers 功能更加强大，并且针对单轴滚动环境进行了优化。
Slivers 托管在 viewports 中，也称为滚动视图，最著名的是 CustomScrollView。

Flutter 有许多内置的 sliver，并与滚动的 RenderBox 相对应，比如：
  SliverList、SliverFixedExtentList(子项高度一致的列表) => ListView
  SliverGrid => GridView
  SliverAppBar => AppBar
  SliverPadding => Padding
  SliverToBoxAdapter => ToBoxAdapter（用于包裹 box widget）,它是一个适配器
  SliverPersistentHeader（粘性吸顶）

 */


import 'package:flutter/material.dart';

class MyCustomScrollView extends StatelessWidget {
  const MyCustomScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,   // 滚动方向
      slivers: [
        // 1、SliverToBoxAdapter 适配器组件，将 Box Widgets 包裹起来作为 sliver
        SliverToBoxAdapter(
          child: Container(
            color: Colors.blue,
            alignment: Alignment.center,
            height: 260,
            child: const Text('轮播图', style: TextStyle(color: Colors.white, fontSize: 28),),
          ),
        ),

        // 设置间距
        const SliverToBoxAdapter(
          child: SizedBox(height: 10,),
        ),

        // 2、SliverPersistentHeader，滚动时会粘性吸顶。
        SliverPersistentHeader(
          delegate: _StickCategory(),
          pinned: true,   // 开启粘性
        ),

        // 3、SliverList 一个列表
        SliverList.separated(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.green,
              height: 100,
              alignment: Alignment.center,
              child: Text("列表${index+1}项", style: const TextStyle(color: Colors.white,fontSize: 20),),
            );
          }, 
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10,);
          }, 
        ),

        // 4、网格列表
        SliverGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
          children: List.generate(20, (int index) {
            return Container(
              color: Colors.amber,
              alignment: Alignment.center,
              child: Text("列表${index+1}项", style: const TextStyle(color: Colors.black, fontSize: 20),),
            );
          }),
        ),

      ],
    );
  } 
}

// SliverPersistentHeaderDelegate 构建粘性 Sliver 的UI界面
class _StickCategory extends SliverPersistentHeaderDelegate {
  // 返回显示的UI
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.pink[100],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blue,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            width: 100,
            child: Text("分类${index+1}", style: const TextStyle(color: Colors.white, fontSize: 18),),
          );
        },
        itemCount: 10
      ),
    );
  }

  // 最大展开时高度，即不吸顶时使用的高度
  @override
  double get maxExtent => 80;

  // 最小折叠时高度，即吸顶时的高度
  @override
  double get minExtent => 50;

  // 是否需要重新构建UI
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}