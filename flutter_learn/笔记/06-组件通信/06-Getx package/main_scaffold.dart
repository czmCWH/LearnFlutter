import 'package:flutter/material.dart';
import './screen/a_screen.dart';
import './screen/b_screen.dart';
import './screen/c_screen.dart';
import './screen/d_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {

  final List<Map<String, String>> _tabList = [
    {
      "icon": "assets/images/tab/home_normal.png",
      "active_icon": "assets/images/tab/home_active.png",
      "title": "路由跳转",
    },
    {
      "icon": "assets/images/tab/pro_normal.png",
      "active_icon": "assets/images/tab/pro_active.png",
      "title": "路由数据",
    },
    {
      "icon": "assets/images/tab/cart_normal.png",
      "active_icon": "assets/images/tab/cart_active.png",
      "title": "状态管理",
    },
    {
      "icon": "assets/images/tab/my_normal.png",
      "active_icon": "assets/images/tab/my_active.png",
      "title": "国际化",
    },
  ];

  int _tabIndex = 0;

  final List<Widget> _pages = [
    ScreenA(),
    ScreenB(),
    ScreenC(),
    ScreenD(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用 IndexedStack 保持底部导航栏对应页面的状态
      body: IndexedStack(
        index: _tabIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _tabIndex = value;
          });
        },
        elevation: 0,   // 导航栏阴影大小，值为 0 时去除阴影。
        type: BottomNavigationBarType.fixed,  // 保持选中item效果不移动
        backgroundColor: Colors.white,   // 背景色
        currentIndex: _tabIndex,
        items: _getTabBarWidget(),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.red,  // 选中按钮的标签颜色
        unselectedItemColor: Colors.grey,   // ：未选中按钮的标签颜色
      ),
    );
  }

  // 返回标签栏底部4个item
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30,),
        activeIcon: Image.asset(_tabList[index]["active_icon"]!, width: 30, height: 30,),
        label: _tabList[index]["title"]!
      );
    });
  }
}