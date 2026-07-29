# Navigator 2.0 的“三剑客”
要实现 Navigator 2.0，你需要协同工作三个主要组件：


## 1、RouteInformationParser<T> (解析器)
* 作用：将外部输入的路由信息（如浏览器地址栏的 URL）解析为 App 内部使用的抽象状态数据对象（T，如：MyRoutePath）。
* 流程：RouteInformation -> T (App State)。
* 作用：把 URL 转 State。

## 2、RouterDelegate<T> (路由代理/逻辑核心)
* 作用：这是导航逻辑的大脑。它持有当前的 App State (T)，负责根据状态构建页面列表，并处理具体的跳转逻辑。
* 它监听状态变化，通知 Router 重建导航堆栈。
* 流程：T (App State，如：MyRoutePath) -> List<Page> (UI堆栈)。
* 作用：State 转 Pages 列表

## 3、Page (页面配置)
* 作用：代表路由栈中每个页面的配置信息。不同于 1.0 直接传 Widget，2.0 使用内置 MaterialPage、CupertinoPage，也可继承 Page 重写 createRoute()。 Page 对象包含了 key、child widget 以及页面切换动画的配置。




# 使用 Navigator 2.0 原生 MaterialApp.router API 实现路由导航模块

路由模块结构：
```
router/                    # 【路由模块核心】
│       ├── app_router.dart        # 路由模块入口（对外暴露 Router 配置）
│       ├── route_path.dart        # 定义路由路径与路由状态
│       ├── app_route_parser.dart  # URL解析：URL -> 状态
│       ├── app_router_delegate.dart # 页面栈管理：状态 -> Pages列表
│       └── route_guard.dart       # (可选) 路由守卫/拦截器
```

## 1、app_router.dart 路由系统的统一入口（对外暴露 Router 配置）
app_router.dart 的职责如下：
- 创建并管理 RouterDelegate
- 创建并管理 RouteInformationParser
- 创建并管理 BackButtonDispatcher
- 对外提供统一的 RouterConfig
- 作为整个路由模块的唯一入口
- 为了方便业务层发起导航，可以在 AppRouter 中增加静态导航方法，将导航入口统一管理，而不是在业务代码中直接访问 RouterDelegate：

app_router.dart 示例：
```dart
import 'package:flutter/material.dart';

import 'route_information_parser.dart';
import 'router_delegate.dart';

/// 应用路由统一入口
///
/// 负责组装整个 Navigator 2.0 路由系统。
class AppRouter {
  AppRouter._();

  /// RouterDelegate
  static final AppRouterDelegate delegate = AppRouterDelegate();

  /// URL 解析器
  static final AppRouteInformationParser parser =
      AppRouteInformationParser();

  /// 返回键分发器
  static final RootBackButtonDispatcher backButtonDispatcher =
      RootBackButtonDispatcher();

  /// 对外统一提供 RouterConfig
  static RouterConfig<Object> get config {
    return RouterConfig<Object>(
      routerDelegate: delegate,
      routeInformationParser: parser,
      backButtonDispatcher: backButtonDispatcher,
    );
  }

  /// 跳转到首页
  static Future<void> goHome() {
    return delegate.setNewRoutePath(AppRoutePath.home());
  }

  /// 跳转到登录页
  static Future<void> goLogin() {
    return delegate.setNewRoutePath(AppRoutePath.login());
  }

  /// 返回上一页
  static bool pop() {
    return delegate.popRoute();
  }
}
```

```dart
import 'package:flutter/material.dart';

import 'router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'VPN',
      routerConfig: AppRouter.config,
    );
  }
}
```



## 2、route_path.dart 定义路由路径与路由状态

1、集中管理路由路径常量；
  ```dart
  class RoutePaths {
    static const String home = '/';
    static const String login = '/login';
    static const String bookList = '/books';
    static const String bookDetail = '/book'; // 基础路径，参数会在逻辑中拼接
  }
  ```
2、定义应用路由状态类；
  ```dart
  /// 这个类会被 RouteInformationParser 和 RouterDelegate 共用
  class AppRoutePath {
    final String? location; // 当前路径名
    final int? bookId;      // 具体的业务参数 (例如书籍ID)
    final bool isUnknown;   // 是否是404

    // 构造函数：私有化，强制使用下面的命名构造函数
    AppRoutePath._({
      this.location,
      this.bookId,
      this.isUnknown = false,
    });

    // 命名构造函数：首页
    AppRoutePath.home() : this._(location: RoutePaths.home);

    // 命名构造函数：登录页
    AppRoutePath.login() : this._(location: RoutePaths.login);

    // 命名构造函数：书籍详情页
    AppRoutePath.bookDetail(this.bookId) 
        : this._(location: RoutePaths.bookDetail);

    // 命名构造函数：404页面
    AppRoutePath.unknown() : this._(isUnknown: true);

    // 辅助方法：重写 equality 判断，以便 Diff 算法能识别状态变化
    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
        other is AppRoutePath &&
            runtimeType == other.runtimeType &&
            location == other.location &&
            bookId == other.bookId &&
            isUnknown == other.isUnknown;

    @override
    int get hashCode => location.hashCode ^ bookId.hashCode ^ isUnknown.hashCode;
  }
  ```
3、封装路径解析与构建逻辑；
  有时，这个文件还会包含一些辅助方法，用于将 URL 转换为参数，或者将参数转回 URL。

