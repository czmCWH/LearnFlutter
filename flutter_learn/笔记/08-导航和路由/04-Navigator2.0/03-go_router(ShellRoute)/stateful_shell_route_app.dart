import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'stateful_shell_route_scaffold.dart';
import 'screen/a_screen.dart';
import 'screen/b_screen.dart';
import 'screen/c_screen.dart';
import 'screen/detail_screen.dart';

/*
 1、StatefulShellRoute（有状态外壳路由）。
  
  它是对普通 ShellRoute 的升级，专门用于实现 BottomNavigationBar（底部导航栏） 架构，且能保持每个标签页（Tab）的状态独立。
  每个 Tab 拥有 独立的 Navigator（嵌套导航器），并支持 状态保持、深度链接（Deep Linking）和参数传递。

 Flutter 官方代码实现：
  <https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart>
 */

class StatefulShellRouteApp extends StatelessWidget {
  const StatefulShellRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Navigator2.0 - go_router(StatefulShellRoute)',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

// 使用 StatefulShellRoute 替代 ShellRoute
final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/a',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell, ) {
          return StatefulShellRouteScaffold(navigationShell: navigationShell);  
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            // 显式指定 navigatorKey，允许通过 _sectionANavigatorKey.currentState!.push(...) 手动操作该 Tab 的 Navigator
            // 其他 Branch 未指定 key，go_router 会自动生成内部 key
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/a',
                builder: (BuildContext context, GoRouterState state) => ScreenA(),
                routes: <RouteBase>[
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) {
                      return const DetailsScreen(label: 'A');
                    },
                  ),
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/b',
                builder: (BuildContext context, GoRouterState state) => const ScreenB(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/c',
                builder: (BuildContext context, GoRouterState state) => const ScreenC(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
