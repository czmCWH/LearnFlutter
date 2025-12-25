// 管理路由
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/Login/index.dart';
import 'package:flutter_shop/pages/Main/index.dart';

// 返回 APP 根级组件
Widget getRootWidget() {
  return MaterialApp(
    // 命名路由
    initialRoute: "/",
    routes: getRootRoutes(),
  );
}

// 返回该 App 的路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    "/": (context) => MainPage(),   // 主页路由
    "/login": (context) => LoginPage(),   // 登录路由
  };
}