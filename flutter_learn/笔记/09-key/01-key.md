# 一、Key class

<https://api.flutter-io.cn/flutter/foundation/Key-class.html>
<https://api.flutter-io.cn/flutter/widgets/Widget/key.html>
<https://docs.flutter.cn/ui#keys>

`Key class` 是 Widget、Element 和 SemanticsNode 的标识符。用于标识唯一性。

- 只有当新 Widget 的 key 与 当前与该 element 关联的 Widget 的 key 相同时，才会使用新 Widget 来更新现有 element。
- 具有相同父 element 的 element 之间的 key 必须是唯一的。
- Key 的子类应该继承 LocalKey 或 GlobalKey。

LocalKey，局部key，只需要在同级组件之间唯一即可。子类有：
  - `ObjectKey`
  - `UniqueKey`
  - `ValueKey<T>`

GlobalKey，全局key，在整个应用中必须是全局唯一。子类有：
  - `GlobalObjectKey`
  - `LabeledGlobalKey`



# 二、Widget.key property

Widget 的 key 属性作用是，控制 Widget 树中一个 Widget 如何替换另一个 Widget。


当 Flutter 在 rebuild widget 树时（比如调用 setState()），它会将 新旧 widget 进行比较，从而决定是否需要重建（rebuild）或重用（reuse）对应的 Element 和 State。有如下2种匹配规则：
  - 1、默认匹配规则（即 widget 无 Key 时）：
    Flutter 框架根据 Widget 的 runtimeType 和 出现顺序 匹配当前版本和上一个版本中的 Widget。
  
  - 2、Widget 启用 Key 
    Flutter 框架根据新旧 Widget 的 runtimeType 和 key 属性分别相等（注意：不是引用相等，而是 operator == ）。

* Widget 匹配相等时：
Flutter 框架则认为新旧 Widget 是同一个逻辑组件，新 Widget 将通过更新底层 Element（即调用 Element.update 方法）来替换旧 Widget。
特点：
  - 不会销毁旧的 Element 和 State。
  - 保持了状态和动画连续性。
  - 对于 StatefulWidget，会调用 State.didUpdateWidget(oldWidget)。

* Widget 匹配不相等时：
Flutter 框架认为新 Widget 是一个全新的 Widget，旧 Element 从树中移除，新 Widget 被创建为新 Element 并插入树中。
特点：
  - 从渲染树中移除旧的 Element（连带其 State 也被 dispose），为新 widget 创建全新的 Element。
  - 导致状态重置和动画中断。

使用 GlobalKey 作为 Widget 的 key，可以让 element 在树中移动（更改父级）而不会丢失 state。当发现一个新的 widget（其键和类型与同一位置的先前控件不匹配），但在前一帧的树中其他地方存在一个具有相同 global key 的 widget 时，该 widget 的元素将被移动到新位置。

通常情况下，如果一个 widget 是另一个 widget 的唯一子 widget，则不需要显式指定 key。


## 总结 - Key 的本质作用

  场景	      无 Key	        有 Key
匹配依据    位置 + 类型	      Key + 类型
状态归属    绑定到“位置”	    绑定到“语义实体”
适用场景    静态 UI	        动态列表、可变 UI
风险	      状态错乱	          状态正确



# 三、Widget.key property 应用场景

Key 在需要创建多个相同类型组件实例的 Widget 中最为有用。

在以下情况必须使用 Key：
  - 列表项可排序、过滤、增删；
  - 动态插入/移除同类型 widget；
  - 需要保持特定 widget 的状态（如动画、输入框内容）；