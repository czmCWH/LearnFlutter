import 'package:flutter/Material.dart';
import 'package:go_router/go_router.dart';
import 'main_screen.dart';
import 'PushGo/one_screen.dart';
import 'PushGo/two_screen.dart';
import 'Value/extra_screen.dart';
import 'Value/path_screen.dart';
import 'Value/query_screen.dart';
import 'Value/return_screen.dart';
import 'Value/value_screen.dart';
import 'Transition/modal_screen.dart';
import 'Transition/scale_screen.dart';
import 'Transition/transition_screen.dart';
import 'Transition/my_custom_dialog.dart';

class AppRouter {

  final GoRouter router = GoRouter(
    initialLocation: '/',
    // 路由守卫（Guards）与重定向（Redirect）,使用 redirect 全局拦截
    redirect: (context, state) {
      // final isLoggedIn = checkAuth(); // 自定义逻辑
      // final isLoggingIn = state.uri.toString().startsWith('/login');

      // if (!isLoggedIn && !isLoggingIn) {
      //   return '/login'; // 重定向到登录页
      // }
      // if (isLoggedIn && isLoggingIn) {
      //   return '/'; // 已登录还访问登录页？跳首页
      // }
      return null; // 不重定向
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => MainScreen(),),

      // 👉 1、处理页面多层级跳转
      GoRoute(path: '/one', builder: (context, state) => const OneScreen()),
      GoRoute(path: '/two', builder: (context, state) => const TwoScreen()),

      // 👉 2、页面跳转传递参数
      GoRoute(path: '/value', builder: (context, state) => const ValueScreen()),
      GoRoute(
        path: '/path/:id/:name',  // 路径参数（:id/:name 为占位符）
        builder: (context, state) {
          // 获取路径参数
          final id = state.pathParameters['id'] ?? '';
          final name = state.pathParameters['name'] ?? '';
          return PathScreen(id: id, name: name,);
        }
      ),
      GoRoute(
        path: '/query',
        builder: (context, state) {
          final query = state.uri.queryParameters['desc'] ?? '';
          return QueryScreen(desc: query,);
        },
      ),
      GoRoute(
        path: '/extra',
        builder: (context, state) {
          final user = state.extra as User?; // 强制转换
          return ExtraScreen(user: user);
        },
      ),
      GoRoute(path: '/return', builder: (context, state) => const ReturnScreen()),
      
      // 👉 3、页面跳转不同样式
      GoRoute(path: '/transition', builder: (context, state) => const TransitionScreen()),
      GoRoute(
        path: '/modal',
        pageBuilder: (context, state) {
          return MaterialPage(
            fullscreenDialog: true, // 关键：实现模态效果
            child: const ModalScreen(),
          );
        },
      ),
      GoRoute(
        path: '/scale',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const ScaleScreen(),
            transitionDuration: const Duration(milliseconds: 600), // 设置动画时长
            reverseTransitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // 组合动画：缩放 + 渐变 + 曲线
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.fastOutSlowIn, // 炫酷的物理曲线
                    ),
                  ),
                  child: RotationTransition(
                    // 轻微的旋转效果，增加动感
                    turns: Tween<double>(begin: -0.02, end: 0.0).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOut),
                    ),
                    child: child,
                  ),
                ),
              );
            },
          );
        },
      ),
      // 定义弹窗路由
      GoRoute(
        path: '/dialog',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            opaque: false, // 关键点：在这里设置透明度，允许看到底层页面
            // 背景遮罩颜色
            barrierColor: Colors.black54, 
            barrierDismissible: true,
            // 关键点 2: 进场动画（这里使用缩放+渐变）
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                  ),
                  child: child,
                ),
              );
            },
            child: const MyCustomDialog(),
          );
        },
      ),
    ],
    
  );

}