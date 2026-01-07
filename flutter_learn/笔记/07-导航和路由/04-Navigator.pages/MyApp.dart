import 'package:flutter/material.dart';
import 'MyPageScreen.dart';


// --- 基于 Navigator.pages 实现 Navigator + Page 路由状态管理

final _navigatorKey = GlobalKey<NavigatorState>();

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static int _counter = 15;

  // 初始页面栈，用 List<Page> 表示当前应该显示的页面栈（从底到顶）
  final List<MyPage> pages = [
    MyPage(
      key: const ValueKey('/'),
      name: '/',
      builder: (context) => const HomeScreen(),
    ),
    // MyPage(
    //   key: const ValueKey('/category/5'),
    //   name: '/category/5',
    //   builder: (context) => const CategoryScreen(id: 5),
    // ),
    // MyPage(
    //   key: const ValueKey('/item/15'),
    //   name: '/item/15',
    //   builder: (context) => const ItemScreen(id: 15),
    // ),
  ];

  // Navigator.onPopPage 接收回调来正确清理 page
  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) return false;

    // 安全移除最后一个页面（因为 pop 总是移除顶部）
    if (pages.length > 1) {
      setState(() {
        pages.removeLast();
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Navigator.pages API声明式导航栈'),
        ),
        body: Navigator(
          key: _navigatorKey,
          onPopPage: _onPopPage,
          pages: List.of(pages), 
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final int id = ++_counter;

            // pages.add 向路由栈添加 Page。
            setState(() {
              pages.add(
                MyPage(
                  key: ValueKey('/item/$id'),
                  name: '/item/$id',
                  builder: (context) => ItemScreen(id: id),
                ),
              );
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}






// 创建一个 Page 子类，可以使用其子类：MaterialPage、CupertinoPage
// Page<T> 中的泛型参数 T 表示该页面所对应的 Route 在被 pop 时返回（返回给上一个路由/调用者）的值的类型（即 pop/result 的类型）。
class MyPage extends Page<void> {
  const MyPage({
    LocalKey? key,
    String? name,
    required this.builder,
  }) : super(key: key, name: name);

  final WidgetBuilder builder;


  // 实现 createRoute 创建自定义的 Route（定制转场、半透明等）。
  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute<void>(
      settings: this,
      builder: builder,
    );
  }

  @override
  String toString() => 'MyPage($name)';
}






