/*
<https://api.flutter-io.cn/flutter/widgets/Stack-class.html>

👉 1、Stack
Stack 是用于在同一“平面”上堆叠多个子 Widget 的容器。

Stack 和 Positioned 配合实现绝对定位。Stack 使得子项堆叠，Positioned 用于根据Stack的四个角来确定子组件的位置。

Stack 的子项是 positioned 或者 non-positioned。
Positioned children 是那些包装在至少有一个非空属性的 Positioned widget 中的元素。
Stack 本身的大小包含所有 non-positioned children，这些 children 根据对齐方式进行定位(在从左到右的环境中默认为左上角，在从右到左的环境中则默认为右上角）。然后根据它们的top、right、bottom 和 left 属性相对于 Stack 放置定位的子元素。

如果要在一个特定的模式中布局一些子节点，或者想做一个自定义布局管理器，需要用 CustomMultiChildLayout 来代替 Stack。
特别是，当使用 Stack 时，不能相对于它们的大小或堆栈本身的大小定位子节点。



 */