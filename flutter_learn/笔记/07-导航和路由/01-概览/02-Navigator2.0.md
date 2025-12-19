# 一、Navigator 2.0 声明式 API 

Flutter Navigator 2.0 指南与原理解析，<https://docs.flutter.cn/community/tutorials/understanding-navigator-v2> & 参考代码：<https://github.com/MeandNi/flutter_navigator_v2/blob/master/lib/pages_example.dart>

Navigator 2.0 API 向框架添加了新的类和其它特性。

## 3.1、Page
<https://api.flutter.dev/flutter/widgets/Page-class.html>

Page，是一个描述页面 Route(路由) 的不可变对象。
  - Page 是一个抽象类，继承自 RouteSettings，通常使用子类：CupertinoPage、MaterialPage、CustomTransitionPage 等。

Navigator 2.0（声明式导航），通过 Navigator.pages 属性接收的 Page 对象数组转换为 Routes 栈。而不是 通过 push/pop 命令式地操作。
Navigator.pages 是状态驱动：只要 Navigator.pages 属性列表发生变化（内容或顺序），Navigator 就会智能 diff 并更新 UI，类似 React 的更新。



## 3.2、Router
<https://api.flutter.dev/flutter/widgets/Router-class.html>










# 四、路由 package
具有高级导航和路由要求的 Flutter 应用（如：具有多个Navigator、 特定 deep linking），推荐使用路由 package（如：`go_router`）。

* `go_router`，<https://pub-web.flutter-io.cn/packages/go_router>