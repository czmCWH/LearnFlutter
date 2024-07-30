# 一、Widget 概述

Flutter 中文开发者社区：<https://flutterchina.club/>
Flutter 中文开发文档：<https://docs.flutter.cn>
Flutter 英文开发文档：<https://docs.flutter.dev/>

Flutter SDK文档：<https://api.flutter-io.cn/index.html>
Flutter issues：<https://github.com/flutter/flutter/issues>


`Flutter widgets` 是使用现代框架构建的，它的灵感来自于 `React`，其中心思想是用 `widgets` 构建`UI`。
 `Widget` 描述了在当前的配置和 `state`(状态) 下视图所应该呈现的样子。简单来说，`widget` 是声明和构建 UI 的方法。 
当 `widget` 的状态发生变化时，`widget`会重新构建其描述，框架会对比前后描述变化的不同，以确定底层渲染树从一种状态过渡到另一种状态所需的最小更改。(类似于`React/Vue`中虚拟`DOM`的`diff`算法）。

`flutter` 库倒入 https://api.flutter.dev/index.html

# 二、基本 widget

Flutter 附带了一套强大的基本 widget，其中常用的有以下几个：

* `Text`，创建一系列有样式的文本。

* `Row, Column`，这些具有弹性空间的布局类 `Widget` 可让您在水平（`Row`）和垂直（`Column`）方向上创建灵活的布局。 这些对象的设计是基于 `web` 开发中的 `Flexbox` 布局模型。

* `Stack`，取代线性布局 (译者语：和Android中的LinearLayout相似)，Stack允许子 widget 堆叠， 你可以使用 [Positioned](https://api.flutter.dev/flutter/widgets/Positioned-class.html) 来定位他们相对于`Stack`的上下左右四条边的位置。`Stacks`是基于Web开发中的绝度定位（`absolute positioning` )布局模型设计的。

* `Container`，用于创建矩形视觉元素。`container`可以使用[BoxDecoration](https://api.flutter.dev/flutter/painting/BoxDecoration-class.html)进行装饰，如背景，边框或阴影。`container`还可以对其大小设置边距（`margins`）、内边距(`padding`)和约束。另外，可以使用矩阵在三维空间中变换`container`。


# 三、Material 设计

<https://docs.flutter.cn/ui/design/material>
<https://docs.flutter.cn/ui/widgets/material>
<https://api.flutter-io.cn/flutter/material/material-library.html>

`Flutter`提供了许多小部件，可帮助您构建遵循 `Material Design` 的应用程序。

从 `Flutter 3.16` 版本开始， Material 3 是 Flutter 的默认主题。

许多 `Material Design widgets` 需要位于 `MaterialApp` 内部才能正确显示。
一个 `Material App` 从 `MaterialApp` widget 开始，它在你的 App 的根处构建了许多有用的 `widget`，包括一个 `Navigator`，它管理一堆由字符串标识的 widgets，也称为 `routes`路由。`Navigator` 允许您在 App 的屏幕之间平滑地切换。

使用 `MaterialApp widget` 是完全可选的，但这是一个很好的做法。

```
// 使用 Materials library 时，需要在 pubspec.yaml 文件中配置如下：

flutter:
  uses-material-design: true
```


> [Material Components](https://docs.flutter.cn/ui/widgets/material) 是 `Flutter` 包含的2个捆绑设计之一。
> 要创建以 `ios` 为中心的设计，请查看 [Cupertino components](https://docs.flutter.cn/ui/widgets/cupertino)，其中有自己的 `CupertinoApp` 和 `CupertinoNavigationBar` 版本


# 四、脚手架搭建 Flutter 

<https://docs.flutter.cn/get-started/test-drive> 在 VS code 创建空项目。

<https://www.insist.life/index.php/2024/04/17/%e5%a5%bd%e7%94%a8%e7%9a%84%e8%84%9a%e6%89%8b%e6%9e%b6%e6%8e%a8%e8%8d%90/>

脚手架工具：GetX+Bruno

# 五、配置 Flutter 项目 gitignore 文件
<https://github.com/flutter/flutter/blob/master/.gitignore>


# 五、Flutter 与其它跨平台对比
https://juejin.cn/post/7329144189001515048?searchId=2024051110482073DE2668163869A23155