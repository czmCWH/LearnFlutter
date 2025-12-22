# 一、Navigator 2.0 声明式 API 

Flutter路由和导航的概览，<https://docs.flutter.cn/ui/navigation>
Flutter Navigator 2.0 指南与原理解析，<https://docs.flutter.cn/community/tutorials/understanding-navigator-v2> & 参考代码：<https://github.com/MeandNi/flutter_navigator_v2/blob/master/lib/pages_example.dart>


Navigator 2.0（声明式导航），通过 Navigator.pages 属性接收的 Page 对象数组，Flutter 会根据所有 Page 对象的 createRoute 方法在底层的路由栈生成对应的 Route 实例，即生成与 pages 对应的路由页面，而不是通过 `Navigator.push/pop` 命令式地操作。
Navigator.pages 是状态驱动：只要 Navigator.pages 属性列表发生变化（内容或顺序），Navigator 就会智能 diff 并更新 UI，类似 React 的更新。

Navigator 2.0 新增的声明式 API 主要包含 Page API、Router API 两个部分。

## Page 页面
<https://api.flutter.dev/flutter/widgets/Page-class.html>

`Page<T>` ，描述 `Route` 实例的配置信息，类型参数 T 表示 Route pop 弹出时的返回类型，通常在 Route 的 `currentResult、popped、didPop` 中使用。

  - Page 是一个抽象类，继承自 RouteSettings，通常使用子类：CupertinoPage、MaterialPage、CustomTransitionPage 等。


## 3.2、Router<T>
<https://api.flutter.dev/flutter/widgets/Router-class.html>

`Router<T>`，用于打开和关闭 App 页面的调度器。继承自 StatefulWidget，它所管理的状态就是应用的 路由状态（即，Navigator.pages）。

Router 的作用是，监听来自操作系统的路由信息，将路由信息解析为 `<T>` 类型的数据，然后将该数据转换为 `Page` 对象，并将其传递给 Navigator。将外部路由信息（如 URL）与 应用内部 UI 状态 同步。

Flutter 提供了新的 `MaterialApp.router` 构造函数来直接在应用顶层构造出全局的 Router 组件（大多数应用只需要一个 Router），从而实现 `Router + Navigator + Page` 路由状态的统一管理。

Router 路由状态管理是通过 RouteInformationParser 和 RouterDelegate 协作完成的。

### Router.routeInformationParser 属性

routeInformationParser 路由信息​​解析器，接收 `RouteInformationParser<T>` 类型。

当 Router 从 routeInformationProvider 获取新的路由信息时，Router 使用使用此委托来解析路由信息并生成配置。该配置将由 routerDelegate 使用，并最终重建 Router widget。

### Router.routerDelegate 属性

routerDelegate 从 `routeInformationParser` 获取配置，并为路由器构建导航小部件。

### Router.backButtonDispatcher 属性

路由器的返回按钮调度器，响应后退按钮，并通知 Router。



# 二、路由 package
Navigator 2.0 与以往不同的方面主要体现在，将路由状态转换成了应用本身的状态。通过 `Navigator.pages` 和 `MaterialApp.router` 2种方式来实现
路由状态管理比较复杂，对于具有高级导航和路由要求的 Flutter 应用（如：具有多个Navigator、 特定 deep linking），推荐使用路由 package（如：`go_router`）。

* `go_router`，<https://pub-web.flutter-io.cn/packages/go_router>