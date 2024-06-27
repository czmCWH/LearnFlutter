/*  <https://api.flutter-io.cn/flutter/material/Scaffold-class.html>
 
👉 1、Scaffold Widget 

Scaffold 实现基本的 Material Design 可视化布局结构。提供用于显示抽屉和底部表单的 API。

要显示一个持久的底部表单，请通过Scaffold.of获取当前 BuildContext 的 ScaffoldState，然后使用 ScaffoldState.showBottomSheet 函数。

> Scaffold 被设计为 MaterialApp 的顶级容器。这意味着在 Material App 的每个 route 上添加一个 Scaffold，将为应用程序提供 Material 的基本视觉布局结构。

通常情况下，Scaffold是不需要嵌套的。例如，在标签栏式`UI`中，`bottomNavigationBar`是一个标签栏，`body`是一个标签视图，你可能会试图将每个标签栏视图变成一个`Scaffold`，带有不同标题的`AppBar`。相反，最好是在 `TabController` 中添加一个监听器来更新`AppBar`。

 */

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: '显示底部弹窗',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('底部弹窗')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        '这是下一页',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          '这是首页',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
