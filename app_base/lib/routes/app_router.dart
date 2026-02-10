import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screen/index.dart';

class AppRouter {

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );
  static final GlobalKey<NavigatorState> _sectionANavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

  // 使用 StatefulShellRoute 替代 ShellRoute
  static final GoRouter routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell, ) {
          return MainScaffold(navigationShell: navigationShell);  
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            // 显式指定 navigatorKey，允许通过 _sectionANavigatorKey.currentState!.push(...) 手动操作该 Tab 的 Navigator
            // 其他 Branch 未指定 key，go_router 会自动生成内部 key
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/home',
                builder: (BuildContext context, GoRouterState state) {
                  return HomeScreen();
                },
                routes: <RouteBase>[
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'detail',
                    builder: (BuildContext context, GoRouterState state) {
                      return const DetailScreen(label: 'A');
                    },
                  ),
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/category',
                builder: (BuildContext context, GoRouterState state) => CategoryScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/cart',
                builder: (BuildContext context, GoRouterState state) => CartScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/mine',
                builder: (BuildContext context, GoRouterState state) => MineScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

}