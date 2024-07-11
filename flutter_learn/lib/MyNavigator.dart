/*
<https://docs.flutter.cn/ui/navigation>
<https://book.flutterchina.club/chapter2/flutter_router.html#_2-4-4-%E8%B7%AF%E7%94%B1%E4%BC%A0%E5%80%BC>
<https://flutter.cn/docs/cookbook/navigation>

https://juejin.cn/post/7156792575016304648

Flutter 提供了一个完整的系统，用于在屏幕之间 导航 和 处理 Deep linking。
  * 没有复杂 deep linking 的小型 App 可以使用 Navigator；
  * 有特定 deep linking 和 导航 要求的 App 使用 Router；

Flutter 有一个命令式路由机制，即 Navigator 组件，还有一个更为惯用的声明式路由机制（类似于 widget 中使用的 build 方法），即 Router。
这两个系统可以一起使用（事实上，声明式系统是使用命令式系统构建的）。


👉 1、Navigator
Navigator 是使用堆栈规程管理一组子 widgets 的窗口 Widget。
一个 route 是一个屏幕或页面的抽象，Navigator 是管理 routes 的 Widget。Navigator 通过 route 入栈和出栈来实现页面之间的跳转。

👉 2、使用 Pages API

如果提供了 Navigator.page，则 Navigator 会将其转换为 一个 Routes 堆栈。
Navigator.pages 中的更改将触发对 Routes 堆栈的更新。Navigator 将更新其 routes，以匹配其 Navigator.pages 的新配置。
要使用这个 API，可以创建 Page 子类，并定义 Navigator.Pages 的 Pages 列表。还需要一个 Navigator.onPopPage 回调，以便在弹出时正确清理输入页面。

默认情况下，Navigator 将使用 DefaultTrantionGenerate 来决定 routes 如何在屏幕内或屏幕外过渡。
要对其进行定制，请定义一个 Trantiongenerate 子类，并将其提供给 Navigator.trantiongenerate。

👉 3、使用 Navigator API

移动应用通常通过称为 screens 或 pages 的全屏元素显示其内容，在 Flutter 中这些元素称为 routes(路由)，它们由 Navigator Widget 管理。
导航器管理一个 Route 对象堆栈，并提供两种管理堆栈的方法: 
    声明式 API Navigator.pages;
    命令式 API Navigator.push 和 Navigator.pop;

3.1、显示 route
虽然您可以直接创建 Navigator，但最常见的是使用 Router 创建的 Navigator。
Router 本身是由 WidgetsApp 或 MaterialApp Widget 创建和配置的。可以使用 navigator.of 来引用那个 navigator。
MaterialApp 是最简单的设置方式。MaterialApp 的 home 将成为 Navigator 堆栈底部的路由。它是您在启动应用时看到的内容。


👉 4、Route
Route 是由 Navigator 管理的 entry(条目) 的抽象。

Route 是一个抽象类，最终实现类为：CupertinoPageRoute、MaterialPageRoute、PageRouteBuilder

Route 在 navigator 和 routes 之间定义了一个抽象接口，这些 routes 在 navigator 上 pushed 和 popped。
大多数 routes 都有视觉支持，它们使用一个或多个 OverlayEntry 对象将其放置在导航器 Overlay 中。

如果 Route.settings 是 Page 的子类，则 route 可以属于 page。
基于页面的路由（与无页面路由相反）是在 Navigator.pages 更新期间通过 Page.createRoute 创建的。
与此路由关联的 Page 可能会在路由的生命周期内发生变化。如果 Navigator 更新此路由的页面，它会调用 changedInternalState 来通知路由页面已更新。

类型参数 T 是路由的返回类型，由 currentResult、popped 和 didPop 使用。如果路由不返回值，则可以使用 void 类型。

👉 5、Page
Page 是描述 Route 配置的一个抽象类。实现的类为：CupertinoPage、MaterialPage
类型参数 T 是相应 Route 的返回类型，由 Route.currentResult、Route.popped 和 Route.didPop 使用。

 */