## Scaffold

[Scaffold](https://api.flutter-io.cn/flutter/material/Scaffold-class.html) 实现 `basic material design` 的视觉布局结构。此类提供用于显示抽屉和 `bottom sheet`(底部工作表) 的 `API`。

要显示一个持久的`bottom sheet`，请通过`Scaffold.of`获取当前`BuildContext`的`ScaffoldState`，并使用 `ScaffoldState.showBottomSheet` 函数。

`Scaffold` 被设计为 `MaterialApp` 的顶级容器。这意味着在 `Material` 应用程序的每个 `route` 上添加一个`Scaffold`，将为应用程序提供`Material`的基本视觉布局结构。

通常情况下，`Scaffold`是不需要嵌套的。例如，在标签栏式`UI`中，`bottomNavigationBar`是一个标签栏，`body`是一个标签视图，你可能会试图将每个标签栏视图变成一个`Scaffold`，带有不同标题的`AppBar`。相反，最好是在 `TabController` 中添加一个监听器来更新`AppBar`。

```Dart
class ScaffOnePage extends StatelessWidget {
  const ScaffOnePage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("scaffold组件"),
          foregroundColor: Colors.amber,
          backgroundColor: Colors.deepPurple,
        ),
        body: const Center(
          child: Text('scaffold组件', style: TextStyle(color: Colors.black, fontSize: 18),),
        ),
      ),
    );
  }
}
```





