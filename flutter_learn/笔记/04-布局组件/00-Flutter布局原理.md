Flutter 中的布局，<https://docs.flutter.cn/ui/layout>
布局，<https://docs.flutter.cn/get-started/fundamentals/layout>
深入理解 Flutter 布局约束，<https://docs.flutter.cn/ui/layout/constraints>

# 一、Flutter 布局

在 Flutter 中，几乎所有东西都是 widget — 甚至布局模型都是 widget。widget 是由它们的 RenderBox 对象进行实际渲染的。

* `布局`，是指 Widgets 的大小及其在屏幕上的位置。

在 Flutter 中，Widget 的大小和位置是由 Widget 与其父组件之间的交互决定的。
理解 Flutter 中的约束是理解 Flutter 布局工作原理的重要组成部分。

## Constraints 约束
Constraints 约束，实际上就是 4 个浮点类型的集合：最大/最小宽度，以及最大/最小高度，其值的单位为 “逻辑像素”。

- `严格约束 (Tight)`，是指设置了确切大小。换句话来说就是，它的最大/最小宽度是一致的，高度也一样。

- `宽松约束 (loose)`，最小宽度/高度为 0。

- `无边界约束（unbounded）`，是指最大宽度或最大高度被设置为双精度浮点数 `double.infinity`。


## Flutter 布局对话

最简单的布局对话：
1. 父 Widget 向子 Widget 传递 Constraints。
2. 子 Widget 会根据 Constraints 确定自身的大小，并将其 width、height 传递给父 Widget。
3. 父 Widget 查看子 Widget 想要的大小和对齐方式，并据此设置组件的位置。

> Flutter 布局对话简化来说：约束向下传递，尺寸向上传递，父 widget 设置位置。

* Flutter 布局特点：
  - 任何给定 Widget 的大小和位置都受其 父Widget 的限制；它不能拥有任意大小，也不能自行决定其在屏幕上的位置。
  - 如果子 Widget 想拥有和 父 Widget 不同的大小，这时父级必须明确它的对齐方式，否则子 Widget 的大小不生效。
  - 如果父级没有设置对齐方式时：
    - 传递 tight 约束，child 被强制为该尺寸；
    - 传递 loose 约束，child 可以在 0..max 之间选择尺寸；
    - 传递 unbounded 约束，child 的尺寸由 child 自身的布局逻辑决定 —— 它可以选择任意有限尺寸；
  
大多数情况下父 Widget 会根据子 Widget 的大小来确定自身的大小。



# 二、其它文档

<https://juejin.cn/post/7306447634204999695#heading-3>
<https://zhengzeqin.netlify.app/2022/04/16/四）Flutter-布局详解/>
<https://juejin.cn/post/6897012238318895117#heading-7>


