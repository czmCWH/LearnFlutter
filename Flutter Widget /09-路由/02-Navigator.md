## Navigator


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

[Cookbook / 导航 (Navigation)]()