# Flutter widget 

* `Flutter` 的核心思想是用 `widget` 来构建你的 `UI` 界面。 `Widget` 描述了在当前的配置和 `state`(状态) 下视图所应该呈现的样子。简单来说，`widget` 是声明和构建 UI 的方法。

* 当 `widget` 的状态改变时，它会重新构建其描述（展示的 UI），框架则会对比前后变化的不同，以确定底层渲染树从一个状态转换到下一个状态所需的最小更改。

在 `Flutter` 中，`widget` 都是不可变的，所以也不能够直接对其修改。所以，你必须通过修改 `widget` 的 `state` 来达到更新视图的目的。

## StatelessWidget

[StatelessWidget](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) (无状态组件)从它们的父 `widget` 接收参数，它们被存储在 `final` 型的成员变量中。 当一个 `widget` 被要求构建时，它使用这些存储的值作为参数来构建 `widget`。

```Dart
import 'package:flutter/material.dart';

class UselessWidget extends StatelessWidget {

  // 定义一个常量构造函数，即初始化参数相同时，创建的对象相同。
  // 该构造函数接收命名参数，textColor 是 required 必须的，tipStr 是 optional 可选的
  const UselessWidget({Key? key, required this.textColor, this.tipStr})
      : super(key: key);

  // 定义常量
  final Color textColor;
  final String? tipStr;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "好好学习",
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, ),
          ),
          Text(
            "天天向上",
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}

// 使用 widget
const UselessWidget(textColor: Colors.black, tipStr: "123",)
```

`stateless widget`是通过构建一组更具体描述用户界面的其他小组件来描述用户界面的一部分的小组件。构建过程将以递归方式继续进行，直到用户界面的描述完全具体为止。

`stateless widget`的`build`方法通常只在三种情况下调用：
* `widget` 第一次插入树中时
* 当`widget`的父级更改其配置时，
* 当[InheritedWidget](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html)依赖更改时。

如果`widget`的父级会定期更改`widget`的配置，或者它依赖于频繁更改的`inherited widgets`，那么优化`build`方法的性能以保持流畅的渲染性能非常重要。

以下几个技术可以用来将`rebuilding a stateless widget`(重建无状态组件)的影响降至最低：

* 将 `build` 方法及其创建的任何 `widget` 所创建的节点数量最小化。例如，不要用 `Rows`、`Columns`、`Paddings` 和 `sizedboxs` 以特别花哨的方式定位单个子项，不如考虑仅使用 `Align` 或 `CustomSingleChildLayout`。考虑一个单独的`CustomPaint`小部件，而不是用多个`Containers`和 `Decorations`进行复杂的分层来绘制正确的图形效果。

* 尽可能使用`const widgets`，并为`widget`提供`const`常量构造函数。

* 当尝试创建可重用的UI时，最好使用`widget`而不是`helper method`。

* 考虑将`stateless widget` 重构为 `stateful widget`，以便它可以使用 `StatefulWidget` 中描述的一些技术，例如缓存子树的公共部分，以及在更改树结构时使用`GlobalKeys`。

* 如果`widget`可能因使用 `InheritedWidgets` 而频繁地重建，请考虑将`stateless widget`重构为多个`widget`，并将树中更改的部分推到叶子上。

## StatefulWidgets

[StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) 具有可变状态的 `widget`。

`State`是指：（1）在构建`widget`时可以同步读取信息，（2）在`widget`的生命周期中可更改信息。 `widget`实现者有责任使用 `State.setState` 确保在状态改变时及时通知`State`。

`StatefulWidget`实例本身是不可变的，它们的可变状态存储在 由`createState`方法创建的单独的`State`对象中，或者存储在该`State`订阅的对象中，例如 `Stream` 或 `ChangeNotifier`对象，对这些对象的引用存储在 `StatefulWidget` 本身的 `final`字段中。

每当对`StatefulWidget` `inflates`(扩充)时，框架都会调用`createState`方法，这意味着如果在树的多个位置插入了同一个`StatefulWidget`，则可能会有多个 `State` 对象与同一个`StatefulWidget` 关联。 类似地，如果从树上删除了 `StatefulWidget`，然后又将其插入树中，则框架将再次调用 `createState` 来创建新的 `State` 对象，从而简化了 `State` 对象的生命周期。

如下是`stateful widget`子类的基本框架：

```Dart
class YellowBird extends StatefulWidget {
  const YellowBird({ Key? key }) : super(key: key);

  @override
  State<YellowBird> createState() => _YellowBirdState();
}

class _YellowBirdState extends State<YellowBird> {
  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFFFFE306));
  }
}
```


`StatefulWidgets` 有两个主要类别：

* 第一个是在 `State.initState ` 中分配资源，并在 `State.dispose` 中处理它们，但它不依赖于 `InheritedWidgets` 或调用 `State.setState`。此类小部件通常用于应用程序或页面的根，并通过 `changenotifier`、`Streams`或其他此类对象与子部件通信。遵循这种模式的有状态部件相对便宜(就CPU和GPU周期而言)，因为它们只构建一次，然后就不会更新了。因此，它们可以有一些复杂而深入的构建方法。

* 第二类是使用 `State.setState` 或依赖于 `InheritedWidgets` 的小部件。这些组件通常会在应用程序的生命周期内多次重建，因此尽量减少重建此类小部件的影响非常重要。(他们也可以使用`State.initState` 或 `State.didChangeDependencies` 并分配资源，但重要的部分是它们重构。)

可以使用以下几种技术来最小化重构有状态小部件的影响：

* 将 `state` 推到 `leaves` 上。

* 将 `build` 方法及其创建的任何小部件所创建的节点数量最小化。

* 如果子树没有更改，则缓存表示该子树的小部件，并在每次可以使用它时重用它。

* 尽可能使用 `const` 小部件。(这相当于缓存一个小部件并重用它。)

* 当尝试创建可重用的UI时，最好使用 `widget` 而不是 `helper method`。

* 如果由于某种原因必须更改深度，请考虑将子树的公共部分包装到具有在有状态小部件的生命周期中保持一致的GlobalKey的小部件中。

```Dart
import 'package:flutter/material.dart';

class BirdWidget extends StatefulWidget {

  // 定义常量构造函数
  const BirdWidget({Key? key, this.color = const Color(0x12000FE2), this.child}): super(key: key);

  final Color color;
  final Widget? child;

  // 存储可变状态
  @override
  State<BirdWidget> createState() {
    return _BirdState();
  }
}

class _BirdState extends State<BirdWidget> {
  double _size = 1.0;

  void grow() {
    setState(() {
      _size += 0.1;
    });
  }

  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.color,
        child: widget.child,
        transform: Matrix4.diagonal3Values(_size, _size, 1.0),
    ); 
  }
}
```



`flutter` 库倒入 https://api.flutter.dev/index.html