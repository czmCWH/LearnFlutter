import 'package:flutter/material.dart';
import 'main_page.dart';

/*
  --- Navigator 命令式 API - 匿名路由
    1、使用步骤：
      1、Navigator.push，跳转新页面，需创建一个 MaterialPageRoute 实例传递。
      2、Navigator.pop，返回上一个页面。
      3、参数传递，与父子组件传递一致，即：页面定义 final 参数，通过构造函数接收。
   
    2、实现功能：
      - 页面跳转传参；
      - 页面转场动画；
      - iOS模态弹窗；
      - 自定义弹窗；
      - 跨页面层级参数传递；？？？
    
    3、Popup routes 弹出式路由的几种实现方式 见 <https://api.flutter.dev/flutter/widgets/Navigator-class.html> Popup routes
      - showDialog、showMenu 和 showModalBottomSheet 函数；
      - MaterialPageRoute.fullscreenDialog 底部弹出覆盖整个屏幕；
      - PageRouteBuilder 自定义转场动画;
      - 自定义 PopupRoute<T>；
      - PopupMenuButton 和 DropdownButton 弹窗菜单按钮；

 */


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,   
      home: const MainPage(),
    );
  }
}