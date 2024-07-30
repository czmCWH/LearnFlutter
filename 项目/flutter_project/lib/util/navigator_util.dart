import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/navigator/tab_navigator.dart';
import 'package:flutter_project/pages/home_page.dart';
import 'package:flutter_project/pages/login_page.dart';
import 'package:flutter_project/widget/hi_webView.dart';

class NavigatorUtil {
  
  /// 用于在获取不到 context 的地方，因此需要在主页中赋值（如：TabNavigator）
  /// 注意：如果 TabNavigator 被销毁了，则会报错
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
      return const TabNavigator();
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
    } else {
      // 让 App 回到手机桌面：导航堆栈中没有可以 pop 的页面，如：点击了 android 的物理返回键，
      SystemNavigator.pop();
    }
  }

  /// 跳转到 h5
  static jumpH5({BuildContext? context, String? url, String? title, bool? hideAppBar, String? statusBarColor}) {
    if (url == null) return;
    BuildContext? safeContext;
    if (context != null) {
      safeContext = context;
    } else if (_context?.mounted ?? false) {
      safeContext = _context;
    } else {
      debugPrint('---- h5 跳转失败, 因为 context 为 null');
    }
    Navigator.push(safeContext!, MaterialPageRoute(builder: (context) {
      return HiWebView(
        url: url,
        title: title,
        hideAppBar: hideAppBar,
        statusBarColor: statusBarColor,
      );
    }));
  }
  
}