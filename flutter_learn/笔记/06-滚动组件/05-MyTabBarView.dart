/*
<https://docs.flutter.cn/ui/widgets/material2>
<https://api.flutter-io.cn/flutter/material/TabBarView-class.html>
<https://book.flutterchina.club/chapter6/tabview.html#_6-9-1-tabbarview>

--- 选项卡式的 PageView

👉 1、TabBarView
TabBarView 是显示与当前选定选项卡对应的 Widget。

TabBarView 通常与 TabBar 结合使用。

如果没有给 TabBarView 提供 TabController，则它必须有一个 DefaultTabController 祖先。
TabController.length 必须等于 children 的长度和 TabBar.tabs 列表的长度。

👉 2、TabController
协调 TabBar 和 TabBarView 之间的选项卡选择。

构建 TabBar 或 TabBarView 的有状态 Widget 可以创建 TabController 并直接共享它。
当 TabBar 和 TabBarView 没有方便的有状态祖先 Widget 时，可以通过提供继承 DefaultTabController 的 Widget 来共享 TabController。

 */

import 'package:flutter/material.dart';

class MyTabBarView extends StatefulWidget {

  const MyTabBarView({ super.key });

  @override
  State<MyTabBarView> createState() {
    // return _MyTabBarView1();
    return _MyTabBarView2();
  }
}

/*
  1、DefaultTabController
  使用 TabBarView，首先需要一个 TabController，它将选定的 标签页 和 可见内容保持同步化，最简单的方式是使用 DefaultTabController。
 */
class _MyTabBarView1 extends State<MyTabBarView> {
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 2,
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: '图片1',),
              Tab(text: '图片2',),
              Tab(text: '图片3',),
            ]
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Image.asset("images/PurpleFlower.jpg"),
            Image.asset("images/WhiteFlower.jpg"),
            Image.asset("images/bluePlace.png"),
          ]
        ),
      ),
    );
  }
}

/*
  2、TabController
 */
class _MyTabBarView2 extends State<MyTabBarView> with SingleTickerProviderStateMixin {
  
  List<Tab> tabs = const <Tab>[
    Tab(text: "新闻",),
    Tab(text: "历史",),
    Tab(text: "图片",),
  ];
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选项卡式的 TabBarView'),
        bottom: TabBar(   // TabBar 为 TabBarView 的导航标题
          tabs: tabs, 
          controller: _tabController,
          indicatorColor: Colors.red,   // 指示器颜色，默认是高度为2的一条下划线
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((Tab tab) {
          final String label = tab.text!.toLowerCase();
          return Center(
            child: Text(
              '页面内容：$label',
              style: const TextStyle(fontSize: 36),
            ),
          );
        }).toList(),
      ),
    );
  }
}
