/*

👉 1、Router
Router 是打开和关闭 App 页面的调度器。

Router Widget 监听来自操作系统的路由信息（例如：App 启动时提供的初始路由、收到意图时获得的新路由，或用户点击系统返回按钮的通知），
将路由信息解析为T类型的数据，然后将该数据转换为 Page 对象，并传递给 Navigator。

可以重写 routeInformationProvider 以更改获取路由名称的方式。
首次创建 Router 时，RouteInformationProvider.value 用作初始路由。
RouteInformationProvider 向其侦听器发出的后续通知将被视为路由信息已更改的通知。

可以重写 backButtonDispatcher 以更改接收后退按钮通知的方式。这必须是一个 BackButtonDispatcher，
它是一个可以注册回调的对象，并且可以被链接，以便将后退按钮的按下委托给辅助路由器。
调用回调以指示用户正试图关闭当前路由（通过按系统后退按钮）；Router 确保在调用此回调时，消息会传递到 routerEDelegate，并将其结果提供回 backButtonDispatcher。
一些平台没有后退按钮（例如iOS和桌面平台）；在这些平台上，永远不会发送此通知。
通常，根路由器的 backButtonDispatcher 是 RootBackButtonDispatcher 的实例，
它使用 WidgetsBindingObserver 来监听来自 SystemChannels.navigation 的 popRoute 通知。
嵌套路由器通常使用 ChildBackButtonDispatcher，必须为其祖先路由器的 BackButtonDispatcher 提供该按钮（可通过Router.of获得）。

可以重写 routeInformationParser，以更改从 routeInformationProvider 获得的名称的解释方式。
它必须实现 RouteInformationParser 接口，该接口专门用于与路由器本身相同的类型。此类型T表示 routeInformationParser 将生成的数据类型。

可以重写 routerDelegate 以更改对 routeInformationParser 输出的解释方式。它必须实现专门用于 T 的 RouterDepate 接口; 
它接受来自 routeInformationParser 的数据(类型为 T)作为输入，并负责提供一个导航小部件以插入到小部件树中。
Routergenerate 接口也是 Listable; 通知意味着路由器需要重新构建。

👉 2、关于异步的担忧
一些 API (特别是那些涉及 RouteInformationParser 和 RouterCommittee 的 API)是异步的。

👉 3、App 架构设计
根据需要，App 可以有零个、一个或多个 Router Widget。

* 如果 App 只有一个“屏幕”，或者 Navigator 提供的功能已经足够，那么它可能没有 Router Widget。这在桌面应用程序中很常见。
* 一个特别复杂的 App 可能在一个树配置中有多个 Router Widget，第一个处理整个路由解析并使结果可用于子树中的路由器。
* 大多数应用程序只需要一个Router。


 */