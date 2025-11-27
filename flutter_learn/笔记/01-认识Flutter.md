# 一、Flutter 文档

Flutter 官网：<https://flutter.cn> 中文网、<https://flutter.dev/> 英文网

Flutter 开发者文档：<https://docs.flutter.cn/posts> 中文、<https://docs.flutter.dev/> 英文
Flutter 社区教程：<https://docs.flutter.cn/community/tutorials> 👍
Flutter SDK文档：<https://api.flutter-io.cn/index.html>、<https://api.flutter.dev/index.html>
Flutter github issues：<https://github.com/flutter/flutter/issues>

<https://doc.flutterchina.club/> --- 【Flutter实战 * 第一版】
<https://book.flutterchina.club/> --- 【Flutter实战 * 第二版】


# 二、Flutter widgets

Flutter widgets 是使用现代框架构建的，它的灵感来自于 React，其中心思想是用 widgets 构建 UI。
Widget 描述了在当前的配置和 state(状态) 下视图所应该呈现的样子。简单来说，widget 是声明和构建 UI 的方法。 
当 widget 的状态发生变化时，widget 会重新构建其描述，框架会对比前后描述变化的不同，以确定底层渲染树从一种状态过渡到另一种状态所需的最小更改。(类似于`React/Vue`中虚拟`DOM`的`diff`算法）。

## Material 设计

`Flutter`提供了许多小部件，可帮助您构建遵循 `Material Design` 的应用程序。

从 `Flutter 3.16` 版本开始， Material 3 是 Flutter 的默认主题。

许多 `Material Design widgets` 需要位于 `MaterialApp` 内部才能正确显示。
一个 `Material App` 从 `MaterialApp` widget 开始，它在你的 App 的根处构建了许多有用的 `widget`，包括一个 `Navigator`，它管理一堆由字符串标识的 widgets，也称为 `routes`路由。`Navigator` 允许您在 App 的屏幕之间平滑地切换。

使用 `MaterialApp widget` 是完全可选的，但这是一个很好的做法。

使用 `Materials library` 时，需要在 `pubspec.yaml` 文件中配置如下：
```
flutter:
  uses-material-design: true
```

> [Material Components](https://docs.flutter.cn/ui/widgets/material) 是 `Flutter` 包含的2个捆绑设计之一。
> 要创建以 `ios` 为中心的设计，请查看 [Cupertino components](https://docs.flutter.cn/ui/widgets/cupertino)，其中有自己的 `CupertinoApp` 和 `CupertinoNavigationBar` 版本


<https://docs.flutter.cn/ui/design/material>
<https://docs.flutter.cn/ui/widgets/material>
<https://api.flutter-io.cn/flutter/material/material-library.html>


## Flutter的重要技术

掘金 * 麦客奥德彪 <https://juejin.cn/post/7371256712106754085>

* 路由和导航：Navigator、Router、命名路由等。
* 本地存储：shared_preferences、sqflite 等。
* 国际化和本地化：Flutter 国际化支持、多语言切换。
* 测试：Widget 测试、集成测试、单元测试。
* 性能优化：Flutter 性能分析、减少重绘、优化构建方法。


# 三、Flutter 与其它跨平台对比
https://juejin.cn/post/7329144189001515048?searchId=2024051110482073DE2668163869A23155