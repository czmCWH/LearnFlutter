import 'package:flutter/material.dart';

/*
 <https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html>
 <https://ducafecat.com/blog/flutter-inherited-widget>

InheritedWidget 本身是 immutable（不可变）的，要更新数据必须重建整个 InheritedWidget。

 实现 InheritedWidget 时需提供 of、maybeOf 静态的便捷方法，供后代获取数据。此静态方法来根据子 Widget 上下文 context 获取 InheritedWidget。
  - of 方法，返回非空实例，如果为空则断言报错；
  - maybeOf 方法，返回一个可空实例；
  - BuildContext 的 dependOnInheritedWidgetOfExactType<T>() 方法用于获取最近的类型为 T 的 InheritedWidget 实例。

 ⚠️，InheritedWidget 不能向上或跨树传递数据，数据流向下单向传递。

 InheritedModel 是 InheritedWidget 的子类。它在 InheritedWidget 基础上，增加了对“部分更新”（partial updates）的支持。
 */

class MyInheritedWidget extends InheritedWidget {
  const MyInheritedWidget({
    super.key,
    required this.userName,
    required this.changeUserName,
    required Widget child, // 包含的子节点
  }) : super(child: child);

  /// 1、定义传递给 子 Widget 的状态
  final String userName;

  /// 2、提供回调函数，供子 Widget 中更新 InheritedWidget 中定义的公共状态
  final Function(String userName) changeUserName;

  /// 3、提供  of、maybeOf 静态方法，供子 Widget 获取 InheritedWidget，并访问其数据
  static MyInheritedWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

  static MyInheritedWidget? of(BuildContext context) {
    final MyInheritedWidget? stateWidget = maybeOf(context);
    // 安全检查
    assert(stateWidget != null, 'No UserProfileState found in context');
    return stateWidget;
  }

  // 4、重写 updateShouldNotify 设置通知更新子 Widget 的规则
  // 如果返回 true，则 Flutter 框架会通知 InheritedWidget 下面的所有子组件；
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return userName != oldWidget.userName;
  }
}
