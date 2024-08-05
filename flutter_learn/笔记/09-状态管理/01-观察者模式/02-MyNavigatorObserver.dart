/*
观察者模式监听路由跳转：https://docs.flutter.cn/community/tutorials/observer-pattern-in-flutter-n-dart#navigator
RouteObserver：<https://api.flutter-io.cn/flutter/widgets/RouteObserver-class.html>

---- 观察者模式监听路由跳转

NavigatorObserver 

 */
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [MyRouteObserver()],
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('观察者模式监听路由跳转',style: TextStyle(color: Colors.black),),),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
               Navigator.push(context, MaterialPageRoute<String>(builder: (BuildContext context) {
                    return const MyDetailPage();
                  }),  
                );
            }, 
            child: const Text('跳转页面'),
          ),
        ],
      ),
    );
  }
}

class MyDetailPage extends StatelessWidget {
  const MyDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('详情页面',style: TextStyle(color: Colors.black),),),
      body: Container(
        color: Colors.redAccent,
      ),
    );
  }
}


class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {

  // 监听导航器的 push 操作
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      debugPrint('push 操作: ${previousRoute.settings.name} => ${route.settings.name}');
    }
  }

  // 监听导航器的 replace 操作
  @override
  void didReplace({ Route<dynamic>? newRoute, Route<dynamic>? oldRoute }) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      debugPrint('replace 操作: ${oldRoute?.settings.name} => ${oldRoute?.settings.name}');
    }
  }

  // 监听导航器的 pop 操作
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      debugPrint('pop 操作: ${route.settings.name} => ${previousRoute.settings.name}');
    }
  }
}