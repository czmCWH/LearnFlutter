import 'package:flutter/material.dart';

/*
 有状态组件生命周期 
 
  1、创建阶段：
    StatefulWidget 被创建 -> createState -> State对象被创建 -> initState -> didChangeDependencies -> build

  2、更新阶段：
    父组件重新build、或自身配置变更 -> didUpdateWidget -> build
  
  3、销毁阶段：
    组件被移除 -> deactivate -> dispose
 */
class StatefulWidgetLife extends StatefulWidget {
  // 定义常量构造函数
  const StatefulWidgetLife({
    Key? key,
    this.color = const Color(0x12000FE2),
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  // 1、创建状态
  @override
  State<StatefulWidgetLife> createState() {
    return _MyStatefulScaffold();
  }
}

// 创建 State
class _MyStatefulScaffold extends State<StatefulWidgetLife> {
  double _size = 0;

  // 2、初始化状态
  // 在小部件创建之前和构建方法之前调用
  @override
  void initState() {
    debugPrint('--- 初始状态数据');
    super.initState();
    // 可进行 初始状态数据、进行网络请求
    _size = 1.0;
  }

  // 3、当每个依赖项更改此状态时调用此方法
  // 在构建小部件的第一次调用initState()之后，也可以立即调用它。
  @override
  void didChangeDependencies() {
    debugPrint('--- didChangeDependencies');
    super.didChangeDependencies();

    // 可进行网络请求
  }

  // 4、当小部件重新构建时，将调用此方法。
  // 这个用于取消订阅在initState()中订阅的旧对象，
  // 并在更新的小部件配置需要替换对象时订阅新对象。
  @override
  void didUpdateWidget(covariant StatefulWidgetLife oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('didUpdateWidget');
  }

  // 5、停用
  // 当小部件暂时从小部件树中移除时，将调用此方法。
  @override
  void deactivate() {
    debugPrint('--- deactivate');
    super.deactivate();
  }

  // 6、释放资源
  // 当小部件从小部件树中永久移除时
  @override
  void dispose() {
    debugPrint('--- 在此处 dispose 释放资源');
    super.dispose();
  }

  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: GestureDetector(
        onTap: grow,
        child: Container(
          color: widget.color,
          transform: Matrix4.diagonal3Values(_size, _size, 1.0),
          child: widget.child,
        ),
      ),
    );
  }

  void grow() {
    // 调用 setState() 会导致 build() 方法再次被调用
    setState(() {
      _size += 0.2;
    });
  }
}
