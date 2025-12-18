/*

 Flutter 3.16 中将弃用的 WillPopScope 替换为 PopScope：<https://ducafecat.com/blog/migrating-from-willpopscope-to-popscope-in-flutter#flutter-%E5%BC%83%E7%94%A8-willpopscope-%E4%BD%BF%E7%94%A8-popscope-%E6%9B%BF%E4%BB%A3%E6%96%B9%E6%B3%95>

 */

import 'package:flutter/material.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static int _counter = 15;

  // Initial Route: /category/5/item/15
  final pages = [
    MyPage(
      name: '/',
      builder: (context) => const HomeScreen(),
    ),
    MyPage(
      name: '/category/5',
      builder: (context) => const CategoryScreen(id: 5),
    ),
    MyPage(
      name: '/item/15',
      builder: (context) => const ItemScreen(id: 15),
    ),
  ];

  void addPage(MyPage page) {
    setState(() => pages.add(page));
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    setState(() => pages.remove(route.settings));
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: $pages');
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: PopScope(
          canPop: false,
          // onPopInvoked: () async => !await _navigatorKey.currentState!.maybePop(),
          child: Navigator(
            key: _navigatorKey,
            onPopPage: _onPopPage,
            pages: List.of(pages),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              final int id = ++_counter;
              pages.add(
                MyPage(
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









class MyPage<T> extends Page<T> {
  MyPage({
    required String name,
    required this.builder,
  }) : super(key: ValueKey<String>(name), name: name);

  final WidgetBuilder builder;

  @override
  Route<T> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: builder,
    );
  }

  @override
  String toString() => '$name';
}




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red,
      child: Center(
        child: Text(
          'Home',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      child: Center(
        child: Text(
          'Category $id',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: Center(
        child: Text(
          'Item $id\n${ModalRoute.of(context)?.settings}',
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
