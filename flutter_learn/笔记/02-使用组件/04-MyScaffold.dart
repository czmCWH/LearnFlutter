/*
<https://docs.flutter.cn/ui/widgets/material2>
<https://docs.flutter.cn/ui/layout>
<https://api.flutter-io.cn/flutter/material/Scaffold-class.html>

--- Material 2 页面骨架 Scaffold

对于 Material app，你可以使用 Scaffold widget，它提供默认的 banner 背景颜色，
还提供有 抽屉(drawers)、提示条(snack bars) 和 底部列表弹窗(bottom sheets) 的 API。

 👉 1、 Scaffold
Scaffold 实现基本的 Material Design 可视化布局结构。

要显示持久性 bottom sheet，需通过 Scaffold.of 获取当前 BuildContext 的 ScaffoldState，并使用 ScaffoldState.showBottomSheet 函数。

 👉 2、避免嵌套 Scaffold
Scaffold 被设计为用于 MaterialApp 的顶级容器。这意味着，在 Material App 上为每条路由添加一个 Scaffold 将为该 App 提供 Material 的基本视觉布局结构。

通常不需要嵌套 Scaffold。例如，在 tabbed UI 中，底部 NavigationBar 是 TabBar，body 是 TabBarView，您可能会想让每个 tab bar view 都成为具有不同标题的 AppBar 的 Scaffold。
相反，最好在 TabController 中添加一个 listener 来更新 AppBar。

 👉 1、Scaffold 布局 和 键盘、iphone X notches(缺口)
Scaffold 扩展以填充可用空间，通常它将占据整个窗口或设备屏幕。

当键盘出现时，Scaffold 的祖先 MediaQuery Widget 的 MediaQueryData.viewInsets 会发生变化，并且 Scaffold 会 rebuilt。
默认情况下，Scaffold 的 body 会调整大小，为键盘腾出空间。要防止调整大小，请将 resizeToAvoidBottomInset 设置为 false。
在这两种情况下，如果焦点小部件位于可滚动容器内，则它将被滚动到视图中。

MediaQueryData.padding 值定义可能不完全可见的区域，例如 iPhone X 上的显示 notch(缺口)。
Scaffold 的 body 不会被此 padding 值插入，尽管 appBar 或 bottomNavigationBar 通常会导致 body 避开 padding。
SafeArea Widget 可用于 Scaffold 的 body 内，以避开显示 notches 等区域。

 👉 4、带有可拖动可滚动 bottom sheet 的 浮动按钮
如果 Scaffold.bottomSheet 是 DraggableScrollableSheet，则设置 Scaffold.floatingActionButton，
并拖动 bottom sheet 以覆盖 Scaffold 高度的 70% 以上，则会同时发生两件事：

Scaffold 开始显示 scrim (参见 ScaffoldState.showBodyScrim )，并且
Scaffold.floatingActionButton 通过使用 Curves.easeIn 的动画缩小，并在 bottom sheet 覆盖整个 Scaffold 时消失。

一旦 bottom sheet 被向下拖动以覆盖 Scaffold 的 70% 以下，scrim 就会消失，Scaffold.floatingActionButton 会动画回到其正常大小。

 */


import 'package:flutter/material.dart';

class MyScaffold extends StatefulWidget {
  // 定义常量构造函数
  const MyScaffold({ super.key });

  // 存储可变状态
  @override
  State<MyScaffold> createState() {
    return _MyScaffold();
  }
}

class _MyScaffold extends State<MyScaffold> with SingleTickerProviderStateMixin {
  
  // 底部标签栏索引
  int _selectedIndex = 1;

  List myTabs = ["新闻", "历史", "图片"];
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this, initialIndex: _selectedIndex,);
    _pageController = PageController(initialPage: 0);
  }

   @override
  void dispose() {
    // 释放资源
    _tabController.dispose();
    super.dispose();
  }

  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),  // 导航栏标题
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.dashboard, color: Colors.orange), //自定义图标
            onPressed: () {
              // 打开抽屉菜单  
              Scaffold.of(context).openDrawer(); 
            },
          );
        }),
        actions: <Widget>[  // 导航栏右侧菜单
          IconButton(icon: const Icon(Icons.share), onPressed: () { }),
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: '显示底部弹窗',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('底部弹窗'))
              );
            },
          ),
        ],
      ),
      
      // body 如果使用 TabBarView，那么切换时必定会有左右滑动动画，所以不使用。
      // body: TabBarView( //构建
      //   controller: _tabController,
      //   physics: const NeverScrollableScrollPhysics(), //禁止滑动
      //   children: myTabs.map((e) {
      //     return Container(
      //         alignment: Alignment.center,
      //         child: Text(e, style: const TextStyle(fontSize: 25),),
      //       );
      //   }).toList(),
      // ),

      body: PageView( 
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), //禁止滑动
        children: myTabs.map((e) {
          return Container(
              alignment: Alignment.center,
              child: Text(e, style: const TextStyle(fontSize: 25),),
            );
        }).toList(),
      ),

      drawer: const _MyDrawer(),  // 抽屉
      bottomNavigationBar: BottomNavigationBar( // 底部导航
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: '商品'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {

    // _tabController.animateTo(index);
    // _tabController.index = index;

    _pageController.jumpToPage(index);

    setState(() {
      _selectedIndex = index;
    });
  }

}



class _MyDrawer extends StatelessWidget {
  const _MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 58.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset("images/phone.png", width: 80,),
                    ),
                  ),
                  const Text("Wendux", style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: const <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}