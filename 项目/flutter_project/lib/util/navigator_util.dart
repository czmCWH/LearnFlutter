import 'package:flutter/material.dart';
import 'package:flutter_project/navigator/tab_navigator.dart';
import 'package:flutter_project/pages/home_page.dart';
import 'package:flutter_project/pages/login_page.dart';

class NavigatorUtil {
  
  /// 用于在获取不到 context 的地方
  static BuildContext? _context;

  static updateContext(BuildContext context) {
    NavigatorUtil._context = context;
    debugPrint('--- update: $context');
  }

  /// 跳转到指定页面
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
        return page;
      })
    );
  }

  /// 跳转到首页
  static goToHome(BuildContext context) {
    //  跳转后，不允许返回
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  /// 跳转到登录页面
  static goToLogin() {
    //  跳转后，不允许返回
    Navigator.pushReplacement(_context!, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }

    /// 标签栏页面
  static goToTabNavigator(BuildContext context) {
    // 跳转后，不允许返回
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const TabNavigator();
    }));
  }

  /// 返回上一页
  static pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}