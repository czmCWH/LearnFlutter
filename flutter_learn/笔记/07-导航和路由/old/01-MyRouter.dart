/*

👉 1、Router
Router 是打开和关闭 App 页面的调度器。

Router Widget 监听来自操作系统的路由信息（例如：App 启动时提供的初始路由、收到意图时获得的新路由，或用户点击系统返回按钮的通知），
将路由信息解析为T类型的数据，然后将该数据转换为 Page 对象，并传递给 Navigator。此过程的每个部分都可以根据需要进行覆盖和配置。

* 可以重写 routeInformationProvider 以更改获取路由名称的方式。
* 首次创建 Router 时，RouteInformationProvider.value 用作初始路由。
* RouteInformationProvider 向其侦听器发出的后续通知将被视为路由信息已更改的通知。

可以重写 backButtonDispatcher 以更改接收后退按钮通知的方式。这必须是一个 BackButtonDispatcher，
它是一个可以注册回调的对象，并且可以被链接，以便将后退按钮的按下委托给辅助路由器。
调用回调以指示用户正试图关闭当前路由（通过按系统后退按钮）；Router 确保在调用此回调时，消息会传递到 routerEDelegate，并将其结果提供回 backButtonDispatcher。
一些平台没有后退按钮（例如iOS和桌面平台）；在这些平台上，永远不会发送此通知。
通常，根路由器的 backButtonDispatcher 是 RootBackButtonDispatcher 的实例，
它使用 WidgetsBindingObserver 来监听来自 SystemChannels.navigation 的 popRoute 通知。
嵌套路由器通常使用 ChildBackButtonDispatcher，必须为其祖先路由器的 BackButtonDispatcher 提供该按钮（可通过Router.of获得）。

可以重写 routeInformationParser，以更改从 routeInformationProvider 获得的名称的解释方式。
它必须实现 RouteInformationParser 接口，该接口专门用于与路由器本身相同的类型。此类型T表示 routeInformationParser 将生成的数据类型。

可以重写 routerDelegate 以更改对 routeInformationParser 输出的解释方式。它必须实现专门用于 T 的 RouterDepate 接口; 
它接受来自 routeInformationParser 的数据(类型为 T)作为输入，并负责提供一个导航小部件以插入到小部件树中。
Routergenerate 接口也是 Listable; 通知意味着路由器需要重新构建。

👉 2、App 架构设计
根据需要，App 可以有零个、一个或多个 Router Widget。

* 如果 App 只有一个“屏幕”，或者 Navigator 提供的功能已经足够，那么它可能没有 Router Widget。这在桌面应用程序中很常见。
* 一个特别复杂的 App 可能在一个树配置中有多个 Router Widget，第一个处理整个路由解析并使结果可用于子树中的路由器。
* 大多数应用程序只需要一个Router。

 */

import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyRouter(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyRouter extends StatefulWidget {

  const MyRouter({ Key? key }) : super(key: key);

  @override
  State<MyRouter> createState() {
    return _MyRouter();
  }
}

class _MyRouter extends State<MyRouter> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: const Center(
        child: Column(
          children: <Widget>[

          ],
        ),
      )
    );
  }
}














class MyRouteParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) {
    return SynchronousFuture(routeInformation.location);
  }

  @override
  RouteInformation restoreRouteInformation(String configuration) {
    return RouteInformation(location: configuration);
  }
}

class MyRouteDelegate extends RouterDelegate<String>
    with PopNavigatorRouterDelegateMixin<String>, ChangeNotifier {
  final _stack = <String>[];

  static MyRouteDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is MyRouteDelegate, 'Delegate type must match');
    return delegate as MyRouteDelegate;
  }

  MyRouteDelegate({
    @required this.onGenerateRoute,
  });

  final RouteFactory onGenerateRoute;

  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  String get currentConfiguration => _stack.isNotEmpty ? _stack.last : null;

  List<String> get stack => List.unmodifiable(_stack);

  void push(String newRoute) {
    _stack.add(newRoute);
    notifyListeners();
  }

  void remove(String routeName) {
    _stack.remove(routeName);
    notifyListeners();
  }

  @override
  Future<void> setInitialRoutePath(String configuration) {
    return setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(String configuration) {
    _stack
      ..clear()
      ..add(configuration);
    return SynchronousFuture<void>(null);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (_stack.isNotEmpty) {
      if (_stack.last == route.settings.name) {
        _stack.remove(route.settings.name);
        notifyListeners();
      }
    }
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    print('${describeIdentity(this)}.stack: $_stack');
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: [
        for (final name in _stack)
          MyPage(
            key: ValueKey(name),
            name: name,
          ),
      ],
    );
  }
}

class MyPage extends Page {
  const MyPage({
    LocalKey key,
    String name,
  }) : super(
    key: key,
    name: name,
  );

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return MyHomePage(title: 'Route: ${name}');
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static int _counter = 0;

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Is this being displayed?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('NO'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('YES'),
            ),
          ],
        );
      },
    );
  }

  void _removeLast() {
    final delegate = MyRouteDelegate.of(context);
    final stack = delegate.stack;
    if (stack.length > 2) {
      delegate.remove(stack[stack.length - 2]);
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    MyRouteDelegate.of(context).push('Route$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:',),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'dialog',
            onPressed: _showDialog,
            tooltip: 'Show dialog',
            child: const Icon(Icons.message),
          ),
          const SizedBox(width: 12.0),
          FloatingActionButton(
            heroTag: 'remove',
            onPressed: _removeLast,
            tooltip: 'Remove last',
            child: const Icon(Icons.delete),
          ),
          const SizedBox(width: 12.0),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
