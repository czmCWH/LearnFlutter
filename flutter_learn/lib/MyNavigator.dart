/*
<https://docs.flutter.cn/ui/navigation>
<https://book.flutterchina.club/chapter2/flutter_router.html#_2-4-4-%E8%B7%AF%E7%94%B1%E4%BC%A0%E5%80%BC>
<https://flutter.cn/docs/cookbook/navigation>

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

 */