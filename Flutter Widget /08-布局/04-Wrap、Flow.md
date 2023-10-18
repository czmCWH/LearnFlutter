
## Wrap

[Wrap](https://api.flutter.dev/flutter/widgets/Wrap-class.html) 在多个水平或垂直`runs` 中显示其子项的小部件。即类似搜索历史页面样式，一行一行摆放item，摆放不下就换行。

`Wrap` 布局每个子项，并尝试将子项与前一个子项相邻放置在主轴上，在两者之间留出间距。如果没有足够的空间容纳子项，`Wrap`将在交叉轴中现有子项旁边创建一个 `run`。

将所有子级分配到 `runs` 后，`runs`内的子级将根据主轴上的 `alignment` 和横轴上的 `crossAxisAlignment` 进行定位。

然后根据 `runSpacing` 和 `runAlignment` 将 `runs` 自身定位在 `crossAxis` 上。

```dart
Container(
  color: Colors.lightBlueAccent,
  // height: 100,
  child: Wrap(
    direction: Axis.horizontal,   // 设置主轴的方向
    verticalDirection: VerticalDirection.down,    // 交叉轴方向上排列子项的顺序和方向
    spacing: 8.0, // 主轴方向上run中的子项之间的间隔
    alignment: WrapAlignment.start,   // run 中的子项如何排列在主轴上
    runAlignment: WrapAlignment.start,    // run 本身如何放置在主轴上
    runSpacing: 0, // 在交叉轴上每行 run 之间的间距
    crossAxisAlignment: WrapCrossAlignment.end,
    children: <Widget>[
      Chip(
        avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('AH')),
        label: const Text('Hamilton'),
      ),
      Chip(
        avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('ML')),
        label: const Text('Lafayette'),
      ),
      Chip(
        avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('HM')),
        label: const Text('Mulligan'),
      ),
      Chip(
        avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('JL')),
        label: const Text('Laurens'),
      ),
    ],
  ),
),
```

## Flow

[Flow](https://api.flutter.dev/flutter/widgets/Flow-class.html) 根据`FlowDelegate` 中的逻辑，有效地调整子项大小和位置的小部件。

`Flow layouts`(流式布局) 针对使用 `transformation matrices`(变换矩阵) 重新定位子级进行了优化。

`Flow` 容器的大小由代理的 `FlowDelegate.getSize` 函数独立于子级。然后根据 `FlowDelegate.getConstraintsForChild` 函数的约束条件，独立地调整子级的大小。

在绘制阶段，使用 `FlowDelegate.paintChildren` 函数中的矩阵，使用 `transformation matrices` 来定位子项，而不是在布局期间定位子项。子项可以通过简单地重新绘制 `flow` 而有效地重新定位，而无需再次布局子项（与`Stack`形成对比，`Stack`在布局过程中一起进行大小调整和定位）。

触发 `Flow` 重绘的最有效方法是向 `FlowDelegate` 的构造函数提供动画。`Flow` 将侦听该动画，并在动画运行时重新绘制，从而避免的构建和布局阶段。

```dart
class MyFlowPage extends StatefulWidget {
  const MyFlowPage({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyFlowPage();
  }
}

class _MyFlowPage extends State<MyFlowPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flow'),),
        body: Container(
          color: Colors.green,
          height: 100,
          child: Flow(
            delegate: MyFlowDelegate(),
            clipBehavior: Clip.antiAlias,
            children: [
              Container(color: Colors.red, height: 50,),
              Container(color: Colors.blueAccent, height: 70,),
              Container(color: Colors.yellow, height: 90,),
            ],
          ),
        ),
      ),
    );
  }
}

class MyFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    var childCount = context.childCount;
    var offY = 20.0;        // Y轴方向的偏移量

    for (int i = 0; i < childCount; ++i) {
      context.paintChild(i, transform: Matrix4.translationValues(0, offY, 0));
      offY += 20;
    }
  }

  @override
  bool shouldRepaint(covariant MyFlowDelegate oldDelegate) {
    return false;
  }
}
```


