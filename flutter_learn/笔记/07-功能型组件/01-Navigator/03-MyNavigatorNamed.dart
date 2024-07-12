/*
<https://api.flutter-io.cn/flutter/widgets/Navigator-class.html>

------ Navigator 跳转命名路由传递参数

1、Navigator.pushNamed  命名路由跳转传参： 
<https://docs.flutter.cn/cookbook/navigation/navigate-with-arguments>

方法一：
  传递：Navigator.pushNamed 方法的 arguments 参数；
  获取：ModalRoute.of() 方法获取

方法二：
  传递：Navigator.pushNamed 方法的 arguments 参数；
  获取：MaterialApp 和 CupertinoApp 构造器中的 onGenerateRoute()；
注意：这种方式适用于 Navigator.pushNamed 跳转的路由没有在 MaterialApp 的 routes 中注册。
 

 
 */

import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyNavigatorNamed(),
      routes: { // 把组件注册到路由表
        _FirstRouteNamePage.routeName: (context) => const _FirstRouteNamePage(),
      },
      // onGenerateRoute 是当 App 导航到 命名路由 时的回调。
      onGenerateRoute: (settings) {
        if (settings.name == _SecondRouteNamePage.routeName) {
          final args = settings.arguments as RouteArguments;
          return MaterialPageRoute(
            builder: (context) {
              return _SecondRouteNamePage(title: args.title, msg: args.message,);
            },
          );
        } else {
          return null;
        }
      },
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyNavigatorNamed extends StatefulWidget {

  const MyNavigatorNamed({ super.key });

  @override
  State<MyNavigatorNamed> createState() {
    return _MyNavigatorNamed();
  }
}

class _MyNavigatorNamed extends State<MyNavigatorNamed> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigator 跳转命名路由 传递参数'),
      ),
      body: ListView(
        children: <Widget>[

          // 1、Navigator.pushNamed 跳转传递参数方式1
          ElevatedButton(
            onPressed: () => {
              Navigator.pushNamed(
                context, 
                _FirstRouteNamePage.routeName, 
                arguments: RouteArguments('页面1', '使用 ModalRoute.of 获取路由参数'),
              )
            },
            child: const Text('使用 ModalRoute.of 获取 Navigator.pushNamed 跳转传递参数'),
          ),

          // 2、Navigator.pushNamed 跳转传递参数方式2
          ElevatedButton(
            onPressed: () => {
              Navigator.pushNamed(
                context, 
                _SecondRouteNamePage.routeName, 
                arguments: RouteArguments('页面2', 'onGenerateRoute 方式获取路由参数'),
              )
            },
            child: const Text('使用 onGenerateRoute 获取 Navigator.pushNamed 跳转传递参数'),
          ),

        ],
      )
    );
  }
}

// 传递路由参数的类
class RouteArguments {
  final String title;
  final String message;

  RouteArguments(this.title, this.message);
}

class _FirstRouteNamePage extends StatelessWidget {
  
  const _FirstRouteNamePage({Key? key}) : super(key: key);

  static const routeName = '/firstRouteNamePage';

  @override
  Widget build(BuildContext context) {

    // 使用 ModalRoute.of 方法获取当前路由携带的参数
    final args = ModalRoute.of(context)!.settings.arguments as RouteArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('从上级传递的参数：${args.message}'),
            ElevatedButton(
              onPressed: () {

              }, 
              child: const Text('返回'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecondRouteNamePage extends StatelessWidget {
  
  const _SecondRouteNamePage({required this.title, required this.msg});

  final String title;
  final String msg;

  static const routeName = '/secondRouteNamePage';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('从上级传递的参数：$msg'),
            ElevatedButton(
              onPressed: () {

              }, 
              child: const Text('返回'),
            ),
          ],
        ),
      ),
    );
  }
}