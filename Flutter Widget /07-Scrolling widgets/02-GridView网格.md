## GridView

要控制滚动视图的初始滚动偏移量，提供一个 `controller` 及其 `ScrollController.initialScrollOffset` 属性。

最常用的网格布局是：

1、[GridView.count](https://api.flutter-io.cn/flutter/widgets/GridView/GridView.count.html) 创建一个在横轴上具有固定数量的 `tiles`(图块) 的布局；

```dart
class MyGridCountWidget extends StatelessWidget {
  const MyGridCountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      crossAxisCount: 3,      // 必要参数，交叉轴上显示item的个数。例如：垂直滚动时，每行3个。
      scrollDirection: Axis.vertical,   // 设置滚动方向，垂直方向滚动
      physics: const BouncingScrollPhysics(),   // 网格组件滚动的物理特性，比如：首位弹簧回缩、不允许滚动范围不超过边界等等
      padding: const EdgeInsets.all(20),    // 网格组件内边距
      mainAxisSpacing: 10,   // 主轴方向的间距
      crossAxisSpacing: 15,   // 辅轴方向的间距
      childAspectRatio: 2/1,    // 子纵横比，决定每个item的size。例如：2/1，表示宽度是高度的2倍
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,    // 滑动时键盘消失
      dragStartBehavior: DragStartBehavior.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text("第一个"),
          color: Colors.teal[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('第二个'),
          color: Colors.teal[200],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('第三个'),
          color: Colors.teal[300],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('第四个'),
          color: Colors.teal[400],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('第五个'),
          color: Colors.teal[500],
        ),
      ],
    );
  }
}
```

2、[GridView.extent](https://api.flutter-io.cn/flutter/widgets/GridView/GridView.extent.html)，它创建一个网格组件，其每个`tiles`(图块)都具有最大 `cross-axis`(交叉轴，垂直于主轴)范围的布局。

```dart
GridView.extent(
	scrollDirection: Axis.vertical,
	maxCrossAxisExtent: 414/2,      // 必要参数，在与主轴垂直的方向上，每个Item的最大显示范围。例如：每个item的最大宽度或者最大高度
	mainAxisSpacing: 10,
	crossAxisSpacing: 15,
	children: <Widget>[
		Container(
			padding: const EdgeInsets.all(8),
			child: const Text("第一个"),
			color: Colors.teal[100],
			),
		Container(
			padding: const EdgeInsets.all(8),
			child: const Text('第二个'),
			color: Colors.teal[200],
			),
		Container(
			padding: const EdgeInsets.all(8),
			child: const Text('第三个'),
			color: Colors.teal[300],
		),
	],
);
```

[GridView.builder](https://api.flutter-io.cn/flutter/widgets/GridView/GridView.builder.html) 构造函数用于创建具有大量（或无限）子级的网格。

`GridView.builder` 构造函数中 `required SliverGridDelegate gridDelegate` 属性，用于控制网格组件中 `tiles`(图块) 的布局。

* 自定义 [SliverGridDelegate](https://api.flutter-io.cn/flutter/rendering/SliverGridDelegate-class.html) 可以生成任意 2D 子项排列，包括未对齐或重叠的排列。

可以使用 `SliverGridDelegate` 的子类 `SliverGridDelegateWithFixedCrossAxisCount` 或 `SliverGridDelegateWithMaxCrossAxisExtent`。

```dart
class MyGridBuildWidget extends StatelessWidget {
  const MyGridBuildWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 交叉轴上item固定数量4
        childAspectRatio: 1 / 2, // item宽高比为1:2
        crossAxisSpacing: 10,
        mainAxisSpacing: 15
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Text('第$index个'),
          color: Colors.blue[100 * (index + 1)],
        );
      },
      itemCount: 9,
      padding: const EdgeInsets.all(10),
    );
  }
}
```

[GridView.custom](https://api.flutter-io.cn/flutter/widgets/GridView/GridView.custom.html) 使用 `gridDelegate` 和 `childrenDelegate` 属性来创建子项，以及子项的布局。

```dart
class MyGridCustomWidget extends StatelessWidget {
  const MyGridCustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 交叉轴上item固定数量4
          childAspectRatio: 1, // item宽高比为1
          crossAxisSpacing: 10,
          mainAxisSpacing: 15),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            color: Colors.red,
            padding: const EdgeInsets.all(1),
            child: Text('...$index'),
          );
        },
        childCount: 10,
        semanticIndexOffset: 0,
      ),
    );
  }
}
```