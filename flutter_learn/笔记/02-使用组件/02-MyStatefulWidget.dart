/* https://api.flutter-io.cn/flutter/widgets/StatefulWidget-class.html

二、StatefulWidget 可变状态 widget

👉 1、State 对象 和 StatefulWidget 的关系
State是指：
1）在构建`widget`时可以同步读取信息
2）在`widget`的生命周期中可更改信息。`widget`实现者有责任使用 `State.setState` 确保在状态改变时及时通知`State`。

StatefulWidget 实例 本身是不可变的，并将其可变状态存储在由 `createState` 方法创建的单独的 `State` 对象中，
或者 存储在该 `State` 订阅的对象中，例如 Stream 或 ChangeNotificationer 对象，这些对象的引用存储在 StatefulWidget 本身的 final 字段中。

框架每次 inflates(扩充) StatefulWidget 时都会调用 `createState`，这意味着如果该 widget 被插入到树的多个位置，则多个 State 对象可能与同一个 StatefulWidget 相关联。
同样，如果 StatefulWidget 从树中移除，然后再次插入树中，框架将再次调用 createState 来创建一个新的 State 对象，从而简化 State 对象的生命周期。

👉 2、GlobalKey StatefulWidget

如果创建者使用 GlobalKey 作为其 key，则 StatefulWidget 在从树中的一个位置移动到另一个位置时 保持相同的 State 对象。
因为带有 GlobalKey 的 widget 最多只能在树中的一个位置使用，所以使用 GlobalKey 的 widget 最多只能有一个关联元素。

在将具有 GlobalKey 的 widget 从树中的一个位置移动到另一个位置时，框架通过将与该小部件相关联的(唯一的)子树从旧位置嫁接到新位置(而不是在新位置重新创建子树)，利用此属性。
与 StatefulWidget 关联的 State 对象与子树的其余部分一起被移植，这意味着 State 对象在新位置被重用（而不是重新创建）。

但是，为了有资格进行移植，必须将 widget 插入到从旧位置移除 widget 的同一动画帧中的新位置。

👉 3、StatefulWidget 有两个主要类别：

第一种是在 State.initState 中分配资源，并在 State.dispose 中处理资源，但它不依赖于 InheritedWidgets 或调用 State.setState。
此类 widget 通常用于应用程序或页面的 根，并通过 changenotifier、Streams 或其他此类对象与 子 widget 通信。
遵循这种模式的 StatefulWidgets 相对便宜(就CPU和GPU周期而言)，因为它们只构建一次，然后永远不会更新。因此，它们可以有一些复杂而深入的构建方法。

第二种是使用 State.setState 或依赖于 InheritedWidgets 的 Widget。
这些 widget 通常会在应用程序的生命周期内 rebuild(重建) 多次，因此尽量减少重建此类 widget 的影响非常重要。(他们也可以使用`State.initState` 或 `State.didChangeDependencies` 并分配资源，但重要的是它们会 rebuild。)

👉 4、最小化 rebuild StatefulWidgets 的影响：

* 将 state 推到 leaves(子节点) 上。

* 尽量减少 build 方法所创建的节点数以及它所创建的任何 widget。

* 如果子树没有更改，则缓存表示该子树的 widget，并在每次可以使用它时重用它。

* 尽可能使用 `const` 小部件。(这相当于缓存一个小部件并重用它。)

* 避免更改任何已创建子树的深度或更改子树中任何小部件的类型。

* 如果由于某种原因必须更改深度，请考虑将子树的公共部分包装在具有 GlobalKey 的 Widget 中，该 widget 在 StatefulWidget 的生命周期内保持一致。

* 当尝试创建可重用的UI时，最好使用 `widget` 而不是 `helper` 方法。

*/

import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  // 定义常量构造函数
  const MyStatefulWidget(
      {Key? key, this.color = const Color(0x12000FE2), this.child})
      : super(key: key);

  final Color color;
  final Widget? child;

  // 存储可变状态
  @override
  State<MyStatefulWidget> createState() {
    return _MyStatefulWidget();
  }
}

class _MyStatefulWidget extends State<MyStatefulWidget> {
  double _size = 1.0;

  void grow() {
    setState(() {
      _size += 0.2;
    });
  }

  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: grow,
      child: Container(
        color: widget.color,
        child: widget.child,
        transform: Matrix4.diagonal3Values(_size, _size, 1.0),
      ),
    );
  }
}

// 使用：MyStatefulWidget(child: Text('好好学习，天天向上'),)