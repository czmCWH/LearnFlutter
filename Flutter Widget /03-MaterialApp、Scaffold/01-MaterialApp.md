## MaterialApp

[MaterialApp](https://api.flutter-io.cn/flutter/material/MaterialApp-class.html)  一个便利的小部件，它包装了 `material design app` 通常需要的许多小部件。它通过添加特定于 `material-design` 的功能(如 `AnimatedTheme` 和 `GridPaper`)来构建`WidgetsApp`。

`MaterialApp` 将其 `WidgetsApp.textStyle` 配置为难看的红色/黄色文本样式，旨在警告开发人员这个 App 尚未定义默认文本样式。通常，`Scaffold` 构建一个 `Material` 小组建，其默认 `Material.textStyle` 定义整个 `Scaffold` 的文本样式。

`MaterialApp` 将顶级 `Navigator` 配置为按以下顺序搜索路由：

1、对于`/`路由，使用 `home` 属性（如果非空）。
2、否则，如果路由表有路由 `entry`(条目)，则使用路由表。
3、否则，调用 `onGenerateRoute`（如果提供）。它为未由 `home` 和`routes`处理的任何有效路由返回非`null`值。
4、最后，如果所有这些都失败了，则调用 `onUnknownRoute`。

如果`MaterialApp`的 `home、routes、onGenerateRoute 和 onUnknownRoute`都为 `null`，而`builder`不为`null`，则不会创建 `Navigator`。


```dart
class MyRoutePage extends StatelessWidget {
  const MyRoutePage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyRouteAPage(),   // 指定 home 路由
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
      theme: ThemeData(   // 配置主题
        brightness: Brightness.light,
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,    // 禁止显示调试横幅
    );
  }
}
```