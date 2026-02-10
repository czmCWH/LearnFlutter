import 'package:router_navigate_demo/app/01-UI/app_1.dart';
import 'package:router_navigate_demo/app/01-UI/app_2.dart';
import 'package:router_navigate_demo/app/01-UI/app_3.dart';
import 'package:router_navigate_demo/app/02-Navigator1.0NamedRoute/App.dart';
import 'package:router_navigate_demo/app/04-go_router_shell_route/shell_route_app.dart';
import 'package:router_navigate_demo/app/04-go_router_shell_route/stateful_shell_route_app.dart';
import 'package:router_navigate_demo/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:router_navigate_demo/app/03-go_router/app.dart' as router_app;
import 'package:router_navigate_demo/app/05-getx/app.dart' as getx_app;

/*
 ⚠️⚠️⚠️，这是一个 路由导航 使用示例 demo
 */

void main() {
  // 1、App 常用页面结构实现方案
  // runApp(MyApp1());
  // runApp(MyApp2());
  // runApp(MyApp3());

  // 2、匿名路由（跳转传参、页面转场动画、自定义弹窗）
  // runApp(MyApp());

  // 3、命名路由
  // runApp(router_app.App());

  // 4、go_router 插件路由
  // runApp(ShellRouteApp());
  runApp(StatefulShellRouteApp());

  // 5、getx 插件的基本使用
  runApp(getx_app.App());
}
