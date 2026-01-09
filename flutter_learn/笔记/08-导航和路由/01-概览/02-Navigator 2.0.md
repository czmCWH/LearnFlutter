# 一、Navigator 2.0

Flutter路由和导航的概览，<https://docs.flutter.cn/ui/navigation>
Flutter Navigator 2.0 指南与原理解析，<https://docs.flutter.cn/community/tutorials/understanding-navigator-v2> 
学习 Flutter 的新导航和路由系统，<https://blog.flutter.dev/learning-flutters-new-navigation-and-routing-system-7c9068155ade> & <https://mp.weixin.qq.com/s/zGpzJahDSTZDhWqYmkzi5g> 参考代码：<https://github.com/MeandNi/flutter_navigator_v2/blob/master/lib/pages_example.dart>


Navigator 2.0 新增的声明式 API 主要包含 Page API、Router API 两个部分。

## Page 和 Router

`Page<T>`，用于描述 Route 的配置信息（如：路由名称、参数、转场动画等），类型参数 T 表示 Route pop 弹出时的返回（返回给上一个路由/调用者）类型，通常在 Route 的 `currentResult、popped、didPop` 中使用。 Page 提供了一个 `createRoute()` 方法用于创建与之对应的 Route 实例。
  - Flutter 框架中预先内置了 `MaterialPage` 和 `CupertinoPage` 两种 Page，便于创建不同风格的 Page。
  - 自定义不同风格的 Page 需使用 `CustomTransitionPage`。

`Router<T>`，是打开和关闭 App 页面的调度器，用来制定要由 Navigator 展示的页面列表。它充当「操作系统路由信息」和「Navigator 页面栈」之间的桥梁。

Router 会监听系统的路由信息（如：初始路由、返回按钮通知 等），将路由信息解析为 T 类型的数据，再将这些数据转换为 Page 对象并传递给 Navigator 导航器。
  - Router 继承自 StatefulWidget，它所管理的状态就是应用的 路由状态。
  - 将外部路由信息（如 URL）与 应用内部 UI 状态 同步。


## Navigator 2.0 原理

Navigator 2.0（声明式导航），通过 Navigator.pages 属性接收的 Page 对象数组，Flutter 会根据所有 Page 对象的 createRoute 方法在底层的路由栈生成对应的 Route 实例，即生成与 pages 对应的路由页面，而不是通过 `Navigator.push/pop` 命令式地修改页面栈。

当 Navigator.pages 发生变化时，会触发路由栈的更新，Navigator 会调整其内部路由以匹配新的 Navigator.pages 配置。

例如：应用打开某个页面，就表示在 pages 中添加一个 Page 对象，系统接收到上层的 pages 改变的通知后就会 比较新的 pages 与旧的 pages，根据比较结果，Flutter 就会在底层路由栈中新生成一个 Route 实例，这样一个新的页面就算打开成功了。

Navigator.pages 是状态驱动：只要 Navigator.pages 属性列表发生变化（内容或顺序），Navigator 就会智能 diff 并更新 UI，类似 React 的更新。


# 二、如何使用 Navigator 2.0

Navigator 2.0 与以往不同的方面主要体现在，将路由状态转换成了应用本身的状态。通过 `Navigator.pages` 和 `MaterialApp.router` 2种方式来实现

## 2.1、Flutter API - Navigator.pages
```dart
@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Books App',
    home: Navigator(
      pages: [
        MaterialPage(
          key: ValueKey('BooksListPage'),
          child: Scaffold(),
        )
      ],
      onPopPage: (route, result) => route.didPop(result),
    ),
  );
}
```

## 2.2、Flutter API - MaterialApp.router

Flutter 提供了新的 `MaterialApp.router` 构造函数来直接在应用顶层构造出全局的 Router 组件（大多数应用只需要一个 Router），从而实现 `Router + Navigator + Page` 路由状态的统一管理。

## 2.3、路由 package

路由状态管理比较复杂，对于具有高级导航和路由要求的 Flutter 应用（如：具有多个Navigator、 特定 deep linking），推荐使用路由 package（如：`go_router`）。

* `go_router`，<https://pub-web.flutter-io.cn/packages/go_router>，go_router 由 Flutter 官方团队（Google）直接维护路由管理插件。

* `Getx`，<https://pub-web.flutter-io.cn/packages/get> <https://github.com/jonataslaw/getx>，Get 是一个微框架，路由管理是其三大功能之一。

# 三、总结
Navigator 1.0 使用 Navigator 管理 Route 路由栈，采用命令式 API Navigator.push() 和 Navigator.pop() 手动将页面入栈或出栈。
  - 学习成本低，移动端友好，Web 支持弱（URL 不会自动同步）。

Navigator 2.0 使应用程序的屏幕（路由）成为应用程序状态的功能，通过 Router 及其关联的 Page 列表来描述当前路由的“状态”。只要状态改变，Flutter 就会根据新的 Page 列表自动匹配路由栈。


提示：
1、开发中定义页面类命名可 `class XxxScreen`，类的文件名建议用 `小写单词+下划线分隔`。不要用 `XxxPage`，与框架中新增的 Page 类区分开来。
2、目前，Flutter 项目常用工程结构：`Provider + go_router` 或者 `GetX`。


