import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: StatefulWidgetLife(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

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

  // 👉 1、创建 State，Widget初始化时被执行
  @override
  State<StatefulWidgetLife> createState() {
    return _MyStatefulScaffold();
  }
}

// 创建 State
class _MyStatefulScaffold extends State<StatefulWidgetLife> {
  double _size = 0;

  // 👉 2、初始化 State
  // 在 State对象插入 Widget 树立刻执行，仅执行一次。
  @override
  void initState() {
    debugPrint('--- 初始状态数据');
    super.initState();
    // 可进行 初始状态数据、订阅对象
    _size = 1.0;
  }

  // 👉 3、当每个依赖项更改此状态时调用此方法
  // 在 initState() 之后，会立即调用它；或者当所依赖的 InheritedWidget 更新时被调用，可被多次调用
  @override
  void didChangeDependencies() {
    debugPrint('--- didChangeDependencies');
    super.didChangeDependencies();

    // 可进行网络请求
  }

  // 👉 4、构建UI界面，初始化时、更新后会被多次调用
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


  // 👉 5、父组件传递新配置时调用，用于比较新旧配置
  // 这个用于取消在initState()中订阅的旧对象，
  // 并在更新的小部件配置需要替换对象时订阅新对象。
  @override
  void didUpdateWidget(covariant StatefulWidgetLife oldWidget) {
    debugPrint('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  // 👉 6、停用
  // 当 State 暂时从 Widget 树中移除时，将调用此方法。
  @override
  void deactivate() {
    debugPrint('--- deactivate');
    super.deactivate();
  }

  // 👉 7、释放资源，永久移除
  // 当 State 对象从 Widget 树中永久移除时调用；仅执行一次
  @override
  void dispose() {
    debugPrint('--- 在此处 dispose 释放资源');
    super.dispose();
  }

  void grow() {
    // 调用 setState() 会导致 build() 方法再次被调用
    setState(() {
      _size += 0.2;
    });
  }
}
