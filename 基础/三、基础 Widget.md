# 三、基础 Widget

## Widget 概述

`Flutter widgets`是使用现代框架构建的，它的灵感来自于 `React`，其中心思想是用 `widgets` 构建`UI`。`widgets`描述了在当前配置和状态下它们的视图应该是什么样子。 当 `widget` 的状态发生变化时，`widget`会重新构建描述，框架会对比前后描述变化的不同，以确定底层渲染树从一种状态过渡到另一种状态所需的最小更改。(类似于`React/Vue`中虚拟`DOM`的`diff`算法）。

一个 `widget` 通常由一些较低级别 `widget` 组成。`Flutter` 框架将依次构建这些 `widget`，直到构建到最底层的子 `widget` 时，这些最低层的 `widget` 通常为`RenderObject`，它会计算并描述`widget`的几何形状。

```Dart
import 'package:flutter/material.dart';

void main() {
  // runApp函数接受给定的Widget并使其成为widget树的根
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // widget的主要工作是实现一个build函数，用以构建自身
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'text widget',
      home: Scaffold(
        body: Center(
          child: Text(
            'hello world!',
          ),
          ),
      ),);
  }
}
```

### 常用 widgets

* `Text`，用于创建一个带格式的文本

* `Row, Column`，这些具有弹性空间的布局类 `Widget` 可让您在水平（`Row`）和垂直（`Column`）方向上创建灵活的布局。 这些对象的设计是基于 `web` 开发中的 `Flexbox` 布局模型。

* `Stack`，取代线性布局 (译者语：和Android中的LinearLayout相似)，Stack允许子 widget 堆叠， 你可以使用 [Positioned](https://api.flutter.dev/flutter/widgets/Positioned-class.html) 来定位他们相对于`Stack`的上下左右四条边的位置。`Stacks`是基于Web开发中的绝度定位（`absolute positioning` )布局模型设计的。

* `Container`，用于创建矩形视觉元素。`container`可以装饰为一个[BoxDecoration](https://api.flutter.dev/flutter/painting/BoxDecoration-class.html)，如背景，边框或阴影。`container`也可以具有边距（`margins`）、填充(`padding`)和应用于其大小的约束(`constraints`)。另外，可以使用矩阵在三维空间中转换`container`。

### Material 组件

`Flutter`提供了许多小部件，可帮助您构建遵循 `Material Design` 的应用程序。

为了继承主题数据，许多`Material`设计`widgets`需要在 `MaterialApp` 中才能正确显示。因此，请使用 `MaterialApp` 运行该应用程序。

`Material` 应用程序以 `MaterialApp` `widget`开始，该 `widget` 在应用程序的根目录下构建了许多有用的`widget`。

注意：`Material` 是 `Flutter` 随附的2个捆绑设计之一。 要创建以iOS为中心的设计，请参阅[Cupertino components](https://flutter.dev/docs/development/ui/widgets/cupertino)，该包具有自己的`CupertinoApp`和`CupertinoNavigationBar`版本。

### 根据用户输入改变 widgets

`StatelessWidget` 从其父 `widget` 接收参数，并将其存储在 `final` 成员变量中。当 `widget` 被要求构建时，它使用这些存储的值作为参数来构建 `widget`。

`StatefulWidgets` 通过生成 `State` 对象来保持状态。



## 参考博客

[Flutter Widget框架概述](https://flutterchina.club/widgets-intro/)

[Introduction to widgets](https://flutter.dev/docs/development/ui/widgets-intro)

[技术胖 * 常用组件](http://jspang.com/detailed?id=42)