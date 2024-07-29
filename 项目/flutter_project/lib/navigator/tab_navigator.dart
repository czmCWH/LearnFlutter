import 'package:flutter/material.dart';
import 'package:flutter_project/util/navigator_util.dart';
import 'package:flutter_project/pages/home_page.dart';
import 'package:flutter_project/pages/searchPage.dart';
import 'package:flutter_project/pages/travel_page.dart';
import 'package:flutter_project/pages/my_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  // PageView 每次切换 page 时，未选中的 page 会被销毁。
  // 要保证 page 常驻内存，为 page 添加 AutomaticKeepAliveClientMixin 。

  final PageController _controller = PageController(initialPage: 0);
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.green;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    // 更新导航器的 context，仅退出登录时使用
    NavigatorUtil.updateContext(context);

    return Scaffold(
      body: PageView(   
        controller: _controller,  
        physics: const NeverScrollableScrollPhysics(),    // 禁止 PageView 左右滑动手势
        children: const [
          HomePage(),
          SearchPage(hideLeft: true,),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('搜索', Icons.search, 1),
          _bottomItem('旅拍', Icons.camera_alt, 2),
          _bottomItem('我的', Icons.account_circle, 3),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor,),
      activeIcon: Icon(icon, color: _activeColor,),
      label: title,
    );
  }

}