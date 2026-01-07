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