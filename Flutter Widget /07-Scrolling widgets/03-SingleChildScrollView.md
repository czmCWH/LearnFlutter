## SingleChildScrollView

[SingleChildScrollView](https://api.flutter-io.cn/flutter/widgets/SingleChildScrollView-class.html) 一个可以滚动单个组件的框。

`SingleChildScrollView` 和 `Column` 来灵活设计布局，可以使得在某些情况下(例如：不同手机屏幕大小、支持屏幕横向模式、分屏模式显示在一个小窗口)，可能没有足够的空间来查看整个内容。

但是如果 `SingleChildScrollView` 中的 `Column` 将尽可能地扩大，那么 `SingleChildScrollView` 将非常昂贵。

```dart
SingleChildScrollView(
  scrollDirection: Axis.vertical,
  padding: const EdgeInsets.all(10),
  physics: const BouncingScrollPhysics(),
  child: Column(
    children: List.generate(6, (index) {
      return Container(
        height: 50*(index + 1),
        color: Colors.primaries[index % Colors.primaries.length],
      );
    }).toList(),
  ),
)
```


