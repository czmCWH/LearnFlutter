/* https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html



在编写 App 时，通常会创建新的 widgets，这些小部件是 `StatelessWidget` 或 `Statfulwidget` 的子类，这取决于 widget 是否管理任何状态。
`widget` 的主要工作是实现 `build()` 函数，该函数用其他较低级别的 widget 来描述 widget。框架依次构建这些 `widget`，直到生成表示底层`RenderObject` 的 widget，`RenderObject` 计算并描述小部件的几何结构。

在 `Flutter` 中，`widget` 都是不可变的，所以也不能够直接对其修改。所以，你必须通过修改 `widget` 的 `state` 来达到更新视图的目的。



一、StatelessWidget 无状态组件

StatelessWidget 从它们的父 `widget` 接收参数，它们被存储在 `final` 类型的成员变量中。
当它被构建时，它使用这些存储的值作为参数来构建 `widget`。它没有要管理的内部状态。

StatelessWidget 的`build`方法通常只在三种情况下调用：
* widget 第一次插入树中时；
* 当`widget`的父级改变其配置时；
* 当它依赖于一个[InheritedWidget](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html)更改时。

如果`widget`的父级会定期更改`widget`的配置，或者它依赖于频繁更改的`inherited widgets`，那么优化`build`方法的性能以保持流畅的渲染性能非常重要。
有几种技术可以用来最小化重建 StatelessWidget 的影响:

* 尽量减少 build 方法所创建的节点数以及它所创建的任何 widget。例如，不要用 `Rows`、`Columns`、`Paddings` 和 `sizedboxs` 以特别花哨的方式定位单个子项，不如考虑仅使用 `Align` 或 `CustomSingleChildLayout`。考虑一个单独的`CustomPaint`小部件，而不是用多个`Containers`和 `Decorations`进行复杂的分层来绘制正确的图形效果。

* 尽可能使用`const widgets`，并为`widget`提供`const`常量构造函数。

* 考虑将`stateless widget` 重构为 `stateful widget`，以便它可以使用 `StatefulWidget` 中描述的一些技术，例如缓存子树的公共部分，以及在更改树结构时使用`GlobalKeys`。

* 如果`widget`可能因使用 `InheritedWidgets` 而频繁地重建，请考虑将`stateless widget`重构为多个`widget`，并将树中更改的部分推到叶子上。

* 当尝试创建可重用的UI时，最好使用`widget`而不是`helper`方法。

 */

import 'package:flutter/material.dart';

class MyStatelessWidget extends StatelessWidget {
  
  // 定义一个常量构造函数，即初始化参数相同时，创建的对象相同。
  // 该构造函数接收命名参数，textColor 是 required 必须的，tipStr 是 optional 可选的
  const MyStatelessWidget({Key? key, required this.textColor, this.tipStr})
      : super(key: key);

  // 定义常量
  final Color textColor;
  final String? tipStr;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text(
            tipStr ?? '默认显示，好好学习',
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, ),
          ),
        ],
      ),
    );
  }
}

// 使用： MyStatelessWidget(textColor: Colors.red, tipStr: '您好，世界！',)