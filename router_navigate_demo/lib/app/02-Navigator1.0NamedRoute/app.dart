import 'package:router_navigate_demo/app/02-Navigator1.0NamedRoute/main_page.dart';
import 'package:router_navigate_demo/app/02-Navigator1.0NamedRoute/one_page.dart';
import 'package:router_navigate_demo/app/02-Navigator1.0NamedRoute/three_page.dart';
import 'package:router_navigate_demo/app/02-Navigator1.0NamedRoute/two_page.dart';
import 'package:router_navigate_demo/app/02-Navigator1.0NamedRoute/four_page.dart';
import 'package:flutter/material.dart';

/*
--- Navigator 组件 - 命名路由
使用步骤：
  1、在 MaterialApp 组件中配置 routes 路由表 和 initialRoute 初始路由（作为App首页）。
  2、使用 Navigator 命令式 API 进行路由：
    Navigator.pushNamed(...)，进入新页面
    Navigator.pushReplacementNamed(...)，替换当前页面
    Navigator.pushNamedAndRemoveUntil(...)，跳转新页面并清理栈
    Navigator.popAndPushNamed(...)，返回并立即跳转新页面
    Navigator.popUntil(...)，连续返回直到满足条件
  3、跳转时传递参数，直接在 pushNamed 中传递即可。
  4、当需要在 initState 中获取路由参数时，请使用 Future.microtask

实现功能：
  1、路由跳转传参；
  2、自定义路由转场动画
  3、模态跳转 - MaterialPageRoute.fullscreenDialog
  4、ageRouteBuilder 自定义转场动画 - 底部弹出
 */

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Navigator 命名路由",
      theme: ThemeData(primarySwatch: Colors.blue),
      // 1、routes 注册路由表
      // ⚠️，命名路由默认使用平台默认动画（Android 滑入，iOS 滑入）。要自定义动画，需在 onGenerateRoute 中返回自定义 PageRoute。
      routes: {
        "/": (context) => const MainPage(),   // 根路由
        "/one": (context) => const OnePage(),
        // "/two": (context) => const TwoPage(),  // 自定义转场动画，不需要配置在路由表中
        // "/three": (context) => const ThreePage(),  // 模态跳转
      },
      // 2、onGenerateRoute 自定义路由生成器（用于自定义动画/模态跳转），用于拦截不在 routes 中注册的路由
      onGenerateRoute: (settings) {
        debugPrint("--- 路由名称 ${settings.name}");
        debugPrint("--- 路由参数 ${settings.arguments}");

        switch (settings.name) {
          case "/two":   // 👉 1、自定义转场动画
            return PageRouteBuilder(
              settings: settings, // 必须传递settings，否则拿不到参数
              pageBuilder: (context, animation, secondaryAnimation) => const TwoPage(),
              // 自定义转场动画：缩放+渐变
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // 缩放动画
                var scaleTween = Tween<double>(begin: 0.6, end: 1.0).chain(
                  CurveTween(curve: Curves.easeOutBack),
                );
                // 渐变动画
                var opacityTween = Tween<double>(begin: 0.0, end: 1.0);

                return ScaleTransition(
                  scale: animation.drive(scaleTween),
                  child: FadeTransition(
                    opacity: animation.drive(opacityTween),
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 500),
            );
          case "/three": 
            // 👉  2、模态
            return MaterialPageRoute(
              builder: (_) => const ThreePage(),
              settings: settings,
              fullscreenDialog: true, // 👈 关键！
            );
          case "/four":
            // 👉  3、PageRouteBuilder 自定义转场动画 - 底部弹出
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (context, animation, secondaryAnimation) => const FourPage(),
              // 模态路由核心：不占满屏幕，带背景遮罩
              opaque: false, // 关键：设置为false，让背景可见
              barrierColor: Colors.black.withOpacity(0.5), // 背景遮罩颜色
              barrierDismissible: true, // 点击背景关闭
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // 从下往上滑入动画
                var slideTween = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeOut));
                return SlideTransition(
                  position: animation.drive(slideTween),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 300),
            );
          default:
            return null;
        }
      },
      // 3、拦截未在 路由表中注册、也未在 onGenerateRoute 中处理的路由，会调用此回调。
      onUnknownRoute: (settings) {
        return null;
      },
      initialRoute: "/",    // initialRoute 设置初始路由，默认使用 / 根路由
    );
  }
}