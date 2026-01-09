import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'shell_route_scaffold.dart';
import 'no_animation_page.dart';
import 'screen/a_screen.dart';
import 'screen/b_screen.dart';
import 'screen/c_screen.dart';
import 'screen/detail_screen.dart';

/*
  go_router 嵌套路由 + 底部导航

 1、go_router 使用 ShellRoute 设置嵌套导航
   如下通过 ShellRoute 构建了一个带有底部导航栏（BottomNavigationBar）的应用壳（App Shell）。支持如下功能：
    - 可以控制页面显示时 底部导航栏（BottomNavigationBar）是否隐藏；
    - 支持 深度链接（Deep Linking），例如直接打开 /b/details；
   
   ⚠️ ShellRoute 不会保留子页面的状态，因此当 底部导航栏（BottomNavigationBar）切换时路由会被销毁或重建，如果需要保留状态则需使用 StatefulShellRoute

   嵌套路由适用于底部导航栏、抽屉菜单等场景。 
   
 2、ShellRoute：

  ShellRoute 的作用是在现有的 UI 结构（如带有侧边栏或底栏的 Scaffold）中“挖个洞”，将子路由渲染在这个“洞”里。

  当向 GoRouter 或 GoRoute 的 routes(路由列表) 中添加 ShellRoute 时，会使用一个新的 Navigator 来显示所有匹配的子路由，
  而不是将它们放在根 Navigator 上。

  要将子路由显示在不同的导航器上，请为其提供一个 parentNavigatorKey，该键与提供给 GoRouter 或 ShellRoute 构造函数的键相匹配。
  如下：将 /b/details 子路由的 parentNavigatorKey 设置为 _rootNavigatorKey，当路由到 /b/details 时：
        - /b/details 会显示在根导航器上，而不是 ShellRoute 的导航器上；
        - 路由到 /b/details 时底部导航栏（BottomNavigationBar）会被隐藏；

  Flutter 官方代码实现：
  <https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/shell_route.dart>
 */

class ShellRouteApp extends StatelessWidget {

  const ShellRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Navigator2.0 - go_router(ShellRoute)',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}

/*
 如下定义2个 GlobalKey 代表了两个独立的“导航栈”：
    _rootNavigatorKey：绑定到根 MaterialApp.router 的 Navigator，表示整个应用的根导航器。用于全局弹出层，比如登录页、全屏弹窗或不带底部导航栏的页面。
    _shellNavigatorKey：绑定到 ShellRoute 创建的 内部 Navigator（即内部嵌套导航器）。专门用于管理底部导航栏（BottomNavigationBar）内的页面栈。
  
 ⚠️：可以通过不同的 navigatorKey，可以控制页面是在“壳内”还是“壳外”显示，如果不指定默认在壳内导航。
 */
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/a',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ShellRouteScaffold(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/a',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoAnimationMaterialPage<void>(
                key: state.pageKey,
                child: const ScreenA(),
              );
            },
            routes: <RouteBase>[
              // 👉 /a/details 没有设置 parentNavigatorKey，默认会 推入 _shellNavigatorKey 对应的 Navigator。
              // 所以详情页只覆盖 ScreenA，底部导航栏仍然显示。
              GoRoute(
                path: 'details',
                builder: (BuildContext context, GoRouterState state) {
                  return const DetailsScreen(label: 'A');
                },
              ),
            ],
          ),
          GoRoute(
            path: '/b',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoAnimationMaterialPage<void>(
                key: state.pageKey,
                child: const ScreenB(),
              );
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'details',
                // 👉 指定 parentNavigatorKey 了，/b/details 会 推入 _rootNavigatorKey 对应的根 Navigator。
                // 所以 /b/details 覆盖整个屏幕（包括 BottomNavigationBar），类似全屏弹窗。
                parentNavigatorKey: _rootNavigatorKey,  
                builder: (BuildContext context, GoRouterState state) {
                  return const DetailsScreen(label: 'B');
                },
              ),
            ],
          ),

          /// The third screen to display in the bottom navigation bar.
          GoRoute(
            path: '/c',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoAnimationMaterialPage<void>(
                key: state.pageKey,
                child: const ScreenC(),
              );
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen C but not the application shell.
              GoRoute(
                path: 'details',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (BuildContext context, GoRouterState state) {
                  return const DetailsScreen(label: 'C');
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
