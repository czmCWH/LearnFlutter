## Navigator

[Navigator](https://api.flutter.dev/flutter/widgets/Navigator-class.html) 管理一组具有堆栈规则的子小部件的小部件。

`App` 通常通过称为 `screens` 或 `pages` 的全屏元素显示其内容。在 `Flutter` 中，这些元素称为 `route`(路由)，它们由 `Navigator` 管理。

* `Navigator` 管理 `Route` 对象的堆栈，并提供两种管理堆栈的方式，声明式API `Navigator.pages` 或 命令式API `Navigator.push` 和 `Navigator.pop`。

默认情况下，`Navigator` 将使用 [DefaultTransitionDelegate](https://api.flutter-io.cn/flutter/widgets/DefaultTransitionDelegate-class.html) 来决定路由如何过渡到屏幕或从屏幕过渡。要对其进行自定义，请定义一个 `TransitionDelegate` 子类并将其提供给 `Navigator.transitionDelegate`。

### Navigator.pages

如果提供了 `Navigator.pages`，则 `Navigator` 会将其转换为 一个 `Routes`堆栈。`Navigator.pages` 的更改将触发 `Routes` 堆栈的更新。`Navigator` 将更新其 `routes`，以匹配其 `Navigator.pages` 的新配置。

要使用这个`Navigator.pages API`，可以创建一个 `Page` 子类，并为 `Navigator.pages` 定义一个 `Pages` 列表。还需要一个 `Navigator.onPopPage` 回调，以便在出现 `pop` 时正确清理输入页面。

### 使用 MaterialApp 创建 Navigator

虽然可以直接的创建 `Navigator`，但是最常见的是使用 `Router` 来创建 `Navigator`，该`navigator` 本身由 `WidgetsApp` 或 `MaterialApp` 小部件创建和配置。可以使用 `Navigator.of` 引用该 `navigator`。

`MaterialApp` 是最简单的设置方式。 `MaterialApp` 的 `home` 成为 `Navigator` 堆栈底部的路由。这是在启动App时看到的内容。

#### Navigator.push

要在堆栈上推送新 `route`，可以使用构建器函数创建 `MaterialPageRoute` 的实例，该构建器函数创建你希望在屏幕上显示的任何内容。

```dart
void main() {
  runApp(const MaterialApp(home: NavigatorOnePage(),));
}

class NavigatorOnePage extends StatelessWidget {
  const NavigatorOnePage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('页面1'),),
      body: Center(
        child: TextButton(
          child: const Text('下一页'),
          onPressed: () async {
            // 等待接受下一个页面返回的值
            final result = await Navigator.push(
              context,
              MaterialPageRoute<String>(builder: (BuildContext context) {
                return const NavigatorTwoPage();
              }),  
            );
            debugPrint(result);     // 这里会打印：点击了返回
          },
        )
      ),
    );
  }
}

class NavigatorTwoPage extends StatelessWidget {
  const NavigatorTwoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('页面2'),),
      body: Container(
        child: Center(
          child: TextButton(
            child: const Text("上一页"),
            onPressed: () {
              Navigator.pop(context, "点击了返回");      // 给上一个页面返回值
            },
          ),
        ),
      ),
    );
  }
}
```

#### Navigator.pushNamed

`App` 通常管理大量的路由，通常通过名称来引用它们是最容易的。按照惯例，路由名使用类似路径的结构(例如，`'/a/b/c'`)。`App` 主页的默认路由名为 `"/"`。

`MaterialApp` 可以通过 `Map<String, WidgetBuilder>` 创建，它从一个路由名称映射到一个将创建它的构建器函数。`MaterialApp` 使用这个映射为导航器的 `onGenerateRoute` 回调创建一个值。

```dart
class MyRoutePage extends StatelessWidget {
  const MyRoutePage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      home: const MyRouteAPage(),   // 指定 home 路由
      initialRoute: '/',        // initialRoute 定义了应用应该从哪个路由启动，使用它时不能指定 home 属性
      routes: <String, WidgetBuilder> {
        // "/": (BuildContext context) => const MyRouteAPage(),   指定 home 路由
        "/b": (BuildContext context) => const MyRouteBPage(),
        "/c": (BuildContext context) => const MyRouteCPage(),
        '/about': (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('About Route'),
            ),
          );
        }
      },
      debugShowCheckedModeBanner: false,    // 禁止显示调试横幅
    );
  }
}
```

按名称显示路由：

```dart
Navigator.pushNamed(context, "/c");
```

### 路由跳转数据传递

#### 例如一：初始化路由时传递 push 参数 

1、设置程序入口，配置首页面参数

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const DeliverPage());
}

class ListModel {
  String name;
  String desc;

  ListModel(this.name, this.desc);
}

class DeliverPage extends StatelessWidget {
  const DeliverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "任务页面",
      home: DataListScreen(
        dataArray:
            List.generate(20, (index) => ListModel("任务$index", "执行情况$index")),
      ),
    );
  }
}
```

2、定义 `DataListScreen` 数据列表页，作为首页

```dart
class DataListScreen extends StatefulWidget {
  const DataListScreen({Key? key, required this.dataArray}) : super(key: key);

  final List<ListModel> dataArray;

  @override
  State<DataListScreen> createState() {
    return _DataListState();
  }
}

class _DataListState extends State<DataListScreen> {
  List<ListModel> dataArray = [];

  @override
  void initState() {
    dataArray = widget.dataArray;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("数据列表页面"),
      ),
      body: ListView.builder(
          itemCount: dataArray.length,
          itemBuilder: (context, index) {
            var textStr = dataArray[index].name + "," + dataArray[index].desc;
            return ListTile(
              title: Text(textStr),
              onTap: () async {     // 通过初始化函数传递参数 push 到详情页，等待 pop 返回数据，来刷新列表页
                final nameStr = await Navigator.push(
                    context,
                    MaterialPageRoute<String>(builder: (BuildContext context) {
                      return DataDetailScreen(data: dataArray[index]);
                    })
                );
                setState(() {
                  dataArray[index].name = nameStr!;
                });
              },
            );
          }),
    );
  }
}
```

2、定义 `DataDetailScreen` 详情页。

```dart
class DataDetailScreen extends StatelessWidget {
  const DataDetailScreen({Key? key, required this.data}) : super(key: key);

  final ListModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(data.desc),
          ),
          TextButton(
              onPressed: () {       // pop 返回并回传数据
                Navigator.pop(context, data.name + "❤️");
              },
              child: const Text("返回")),
        ],
      ),
    );
  }
}
```

#### 例如二：使用 `MaterialPageRoute.settings` 传递 push 参数

```dart
() async {
  final nameStr = await Navigator.push(
    context,
    MaterialPageRoute<String>(
      builder: (BuildContext context) {
        return const DataDetailScreen();
      },
      settings: RouteSettings(
          arguments: dataArray[index]
      )
    ),
  );
  setState(() {
    dataArray[index].name = nameStr!;
  });
},
```

要接收 `RouteSettings` 中传递的数据，需要使用 [ModalRoute.of(context)](https://api.flutter-io.cn/flutter/widgets/ModalRoute/of.html)，它 会返回带有参数的当前路由。

```dart
class DataDetailScreen extends StatelessWidget {
  const DataDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ListModel data = ModalRoute.of(context)?.settings.arguments as ListModel;

    return Scaffold(...);
  }
}
```

#### 例如三：使用 `onGenerateRoute` 提取 `push` 传递的参数


```dart
class PassApp extends StatelessWidget {
  const PassApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePassScreen.routeName,
      routes: {
        HomePassScreen.routeName: (BuildContext context) => const HomePassScreen(),
        DetailOneScreen.routeName: (BuildContext context) => const DetailOneScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == DetailTwoScreen.routeName) {
          final args = settings.arguments as DataArgModel;
          return MaterialPageRoute(builder: (BuildContext context) {
            return DetailTwoScreen(title: args.title, num: args.num);
          });
        }
        return null;
      },
    );
  }
}
```

一级页面：

```dart
class DataArgModel {
  String title;
  int num;
  DataArgModel(this.title, this.num);
}

class HomePassScreen extends StatelessWidget {
  const HomePassScreen({Key? key}): super(key: key);

  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("首页"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, DetailOneScreen.routeName, arguments: DataArgModel("页面1", 100));
              },
              child: const Text("跳转页面1"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, DetailTwoScreen.routeName, arguments: DataArgModel("页面2", 200));
              },
              child: const Text("跳转页面2"),
            )
          ],
        ),
      ),
    );
  }
}
```

两个二级页面：

```dart
class DetailOneScreen extends StatelessWidget {
  const DetailOneScreen({Key? key}): super(key: key);

  static const routeName = '/detailOnePage';

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as DataArgModel;

    return Scaffold(
      appBar: AppBar(title: Text(args.title),),
      body: Center(
        child: Text("数量为：${args.num}"),
      ),
    );
  }
}
```

```dart
class DetailTwoScreen extends StatelessWidget {
  static const routeName = '/detailTwoPage';

  final String title;
  final int num;
  const DetailTwoScreen({Key? key, required this.title, required this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Center(
        child: Text("数量为：$num"),
      ),
    );
  }
}
```


## 参考文档

[路由和导航](https://flutter.cn/docs/development/ui/navigation)

[Cookbook / 导航 (Navigation)](https://flutter.cn/docs/cookbook/navigation)