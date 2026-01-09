import 'package:flutter/material.dart';
import './screen/cart_page.dart';
import './screen/find_page.dart';
import './screen/home_page.dart';
import './screen/mine_page.dart';

/*
  1、导航栏+底部标签栏 - 实现2：
    Scaffold(
      body: PageView(
        children: []
      ),
      bottomNavigationBar: Theme(
        child: BottomNavigationBar(
        ),
      ),
    )

    使用 Theme Widget 包裹 BottomNavigationBar 去掉 涟漪效果、圆圈阴影效果。

  ⚠️：PageView 点击切换时，其 Page 会被 dispose，解决办法：让 Page 混入 AutomaticKeepAliveClientMixin，见 FindPage 实现。
 */

class MyApp2 extends StatefulWidget {
  const MyApp2({super.key});

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
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
  
  late PageController _pageViewController;
  int _tabIndex = 0;

   @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: 0);
  }

   @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
      home: Scaffold(
        body: PageView(
          controller: _pageViewController,  
          physics: const NeverScrollableScrollPhysics(),    // 禁止 PageView 左右滑动手势
          children: [
            HomePage(),
            FindPage(),
            CartPage(),
            MinePage(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory, // 去掉涟漪效果
            highlightColor: Colors.transparent,    // 去掉点击高亮
          ), 
          child: BottomNavigationBar(
            onTap: _onTappedItem,
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
        )
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

  // 点击标签栏
  void _onTappedItem(int index) {
    // _pageViewController.animateToPage(
    //   value,
    //   duration: const Duration(milliseconds: 400),
    //   curve: Curves.easeInOut,
    // );
    _pageViewController.jumpToPage(index);
    setState(() {
      _tabIndex = index;
    });
  }

}