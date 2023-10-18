## PageView

[PageView](https://api.flutter-io.cn/flutter/widgets/PageView-class.html) 一个可以一页一页滚动的列表。`PageView` 的子项必须和它显示大小一样大。

[PageController](https://api.flutter-io.cn/flutter/widgets/PageController-class.html) 控制 `PageView` 中可见的子项。它可以控制 `PageView` 内容的偏移，以及页面的偏移。

`PageController.initialPage` 决定了PageView第一次构造时显示哪个页面。

`PageController.viewportFraction` 决定了页面的大小作为 `viewport` 大小的一部分。


```dart
Center(
  child: SizedBox(
    height: 300,
    child: PageView(
      scrollDirection: Axis.vertical,
      controller: PageController(initialPage: 0, viewportFraction: 0.8),
      physics: const BouncingScrollPhysics(),
      pageSnapping: false,
      onPageChanged: (int index) {
        debugPrint('索引 $index 发生了改变');
      },
      allowImplicitScrolling: false,
      children: [
        Center(
          child: Container(
            width: 200,
              height: 300,
              color: Colors.red,
              child: const Text('111')
          ),
        ),
      ],
    ),
  ),
),
```
