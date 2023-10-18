## Listener

使用 `Listener` 可以在组件层直接监听指针事件。然而，一般情况下，请考虑使用 `gestures` 替代。

[Listener](https://api.flutter-io.cn/flutter/widgets/Listener-class.html) 用于调用回调以响应常见的指针事件。

`Listener` 会监听可以构造手势的事件，例如当指针被 `pressed`、`moved`、`released`、`canceled`。

`Listener`不会监听鼠标独有的事件，例如鼠标在不按任何按钮的情况下进入、退出或悬停某个区域。对于这些事件，请使用 `MouseRegion`。

如果 `Listener` 有子项，它将遵从孩子的大小调整行为。如果没有子项，它会成长以适应父母。

* 与其听原始指针事件，不如考虑使用 `GestureDetector` 接收更高级的手势。

```dart


```