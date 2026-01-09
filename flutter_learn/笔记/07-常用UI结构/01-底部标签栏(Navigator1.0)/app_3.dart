import 'package:flutter/material.dart';
import './screen/cart_page.dart';
import './screen/find_page.dart';
import './screen/home_page.dart';
import './screen/mine_page.dart';

/*
  1、导航栏+底部标签栏 - 实现3：
    Scaffold(
      body: [][_tabIndex],
      bottomNavigationBar: Theme(
        child: NavigationBar(   // Material 3
        ),
      ),
    )
 */

class MyApp3 extends StatefulWidget {
  const MyApp3({super.key});

  @override
  State<MyApp3> createState() => _MyApp3State();
}

class _MyApp3State extends State<MyApp3> {
  final List<Map<String, String>> _tabList = [
    {
      "icon": "assets/images/tab/home_normal.png",
      "active_icon": "assets/images/tab/home_active.png",
      "title": "首页",
    },
    {
      "icon": "assets/images/tab/pro_normal.png",
      "active_icon": "assets/images/tab/pro_active.png",
      "title": "分类",
    },
    {
      "icon": "assets/images/tab/cart_normal.png",
      "active_icon": "assets/images/tab/cart_active.png",
      "title": "购物车",
    },
    {
      "icon": "assets/images/tab/my_normal.png",
      "active_icon": "assets/images/tab/my_active.png",
      "title": "我的",
    },
  ];
  
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
      home: Scaffold(
        body: <Widget>[
          HomePage(),
          FindPage(),
          CartPage(),
          MinePage(),
        ][_tabIndex],   
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory, // 去掉涟漪效果
            highlightColor: Colors.transparent,    // 去掉点击高亮
          ), 
          child: NavigationBar(    // NavigationBar 是 Material 3 新增的底部标签栏 widget
            selectedIndex: _tabIndex,
            destinations: _getTabBarWidget(),   // 定义导航按钮集合
            onDestinationSelected: _onTappedItem,
            backgroundColor: Colors.white,  // 背景色
            elevation: 0,
            shadowColor: Colors.transparent,    // 导航栏阴影颜色
            indicatorColor: Colors.transparent,   // 选中按钮的背景色
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          )
        ),
      ),
    );
  }

  // 返回标签栏底部4个item
  List<NavigationDestination> _getTabBarWidget() {
    return List.generate(_tabList.length, (int index) {
      return NavigationDestination(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30,),
        selectedIcon: Image.asset(_tabList[index]["active_icon"]!, width: 30, height: 30,),
        label: _tabList[index]["title"]!
      );
    });
  }

  // 点击标签栏
  void _onTappedItem(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

}














class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
            label: 'Messages',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text('Home page', style: theme.textTheme.titleLarge),
            ),
          ),
        ),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}
