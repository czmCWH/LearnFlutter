# 一、Flutter 与其它跨平台对比
https://juejin.cn/post/7329144189001515048?searchId=2024051110482073DE2668163869A23155

# 二、Widget
<https://docs.flutter.cn/ui/widgets>
<https://docs.flutter.cn/get-started/fundamentals/widgets>

Flutter widgets 是使用现代框架构建的，它的灵感来自于 React，其中心思想是用 widgets 构建 UI。Flutter 中万物皆 Widget。

Widget 描述了在当前的配置和 state(状态) 下视图所应该呈现的样子。简单来说，widget 是声明和构建 UI 的方法。 

当 widget 的状态发生变化时，widget 会重新构建其描述，框架会对比前后描述变化的不同，以确定底层渲染树从一种状态过渡到另一种状态所需的最小更改。(类似于`React/Vue`中虚拟`DOM`的`diff`算法）。


# 三、Widget 三棵树
