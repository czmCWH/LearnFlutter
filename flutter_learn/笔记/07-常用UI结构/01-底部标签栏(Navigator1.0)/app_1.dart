import 'package:flutter/material.dart';
import './screen/cart_page.dart';
import './screen/find_page.dart';
import './screen/home_page.dart';
import './screen/mine_page.dart';

/*
  1、导航栏+底部标签栏 - 实现1：
    Scaffold(
      body: IndexedStack(
        children: []
      ),
      bottomNavigationBar: BottomNavigationBar(
        //...
      ),
    )

    使用 MaterialApp.theme 全局去掉点击 涟漪效果、圆圈阴影效果。

  2、BottomNavigationBar：在  Material 3 中已更新为 NavigationBar
 */

class MyApp1 extends StatefulWidget {
  const MyApp1({super.key});

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
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
        splashFactory: NoSplash.splashFactory,    // 全局去掉点击涟漪效果
        highlightColor: Colors.transparent,   // 全局去掉点击圆圈阴影效果
      ),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
      home: Scaffold(
        body: IndexedStack(
          index: _tabIndex,
          children: [
            HomePage(),
            FindPage(),
            CartPage(),
            MinePage(),
          ],
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