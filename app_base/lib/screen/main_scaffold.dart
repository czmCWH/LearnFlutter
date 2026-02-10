import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class MainScaffold extends StatelessWidget {

  MainScaffold({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          navigationShell.goBranch(index);
        },
        elevation: 0,   // 导航栏阴影大小，值为 0 时去除阴影。
        type: BottomNavigationBarType.fixed,  // 保持选中item效果不移动
        backgroundColor: Colors.white,   // 背景色
        currentIndex: navigationShell.currentIndex,
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

  // ignore: unused_element
  // void _onTap(BuildContext context, int index) {
  //   navigationShell.goBranch(
  //     index,
  //     initialLocation: index == navigationShell.currentIndex,
  //   );
  // }
}