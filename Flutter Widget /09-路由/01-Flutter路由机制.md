## Flutter的路由机制

一个 `route` 是一个屏幕或页面的抽象，`Navigator` 是管理 `route` 的 `Widget`。`Navigator` 可以通过 `route` 入栈和出栈来实现页面之间的跳转。


* `Flutter` 有一个命令式路由机制，即 `Navigator` 组件，还有一个更为惯用的声明式路由机制（类似于 `widget` 中使用的 `build` 方法），即 [Router](https://api.flutter-io.cn/flutter/widgets/Router-class.html) 组件。这两个系统可以一起使用（事实上，声明式系统是使用命令式系统构建的）。

> 对于小型应用程序来说，通常只需通过 `MaterialApp` 构造函数中的 `MaterialApp.routes` 属性，加以使用 `Navigator API`，就可以很好地提供服务。

> 通过 `MaterialApp.router` 构造函数，`Router API` 可以更好地为复杂应用程序服务。它需要更多的前期工作来描述如何解析应用程序的复杂路由，以及如何将应用程序的状态映射到页面集合，但从长远的角度来看会使路由的控制更具表现力。

> 在 `Flutter` 中，屏 (`screen`) 和 页面 (`page`) 都叫做 路由 (`route`)，在下文中统称为“路由 (`route`)”。


## Route

[Route](https://api.flutter.dev/flutter/widgets/Route-class.html)一个抽象类，它是由 `Navigator` 管理的 `entry`(条目) 的抽象。 

此类定义了 `navigator`和 `routes` 之间的抽象接口，这些 `routes` 在 `navigator` 上 `pushed` 和 `popped`。

大多数 `routes` 都有视觉支持，它们使用一个或多个 [OverlayEntry](https://api.flutter-io.cn/flutter/widgets/OverlayEntry-class.html) 对象将其放置在`navigators` 的 [Overlay](https://api.flutter-io.cn/flutter/widgets/Overlay-class.html) 中。

如果 `Route.settings` 是一个 [Page](https://api.flutter.dev/flutter/widgets/Page-class.html)的子类，则 `route`可以属于一个 `Page`。在 `Navigator.pages` 更新期间，从 `Page.createRoute` 创建基于`Page`的`Route`。与此 `route` 关联的 `page` 可能在 `route` 的生命周期内改变。如果 `Navigator` 更新此 `route` 的 `page`，它会调用 `changedInternalState` 来通知`route` 该 `page`已经更新了。

[OverlayRoute](https://api.flutter-io.cn/flutter/widgets/OverlayRoute-class.html)是 `Route` 的子类，在 `Navigator.Overlay` 中显示小部件的 `route`。

[MaterialPageRoute](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html) 是 `OverlayRoute` 的子类，它使用平台自适应过渡替换整个屏幕。

## Page

[Page](https://api.flutter.dev/flutter/widgets/Page-class.html) 一个抽象类，用于描述 `Route` 的配置。

类型参数 `T` 是对应 `Route` 的返回类型，由 `Route.currentResult`、`Route.popped` 和 `Route.didPop` 使用。

`Page` 的子类有 `CupertinoPage` 和 `MaterialPage`。