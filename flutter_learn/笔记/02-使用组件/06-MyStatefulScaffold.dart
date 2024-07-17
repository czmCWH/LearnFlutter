import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyStatefulScaffold(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

// 创建状态
class MyStatefulScaffold extends StatefulWidget {
  // 定义常量构造函数
  const MyStatefulScaffold({
    Key? key,
    this.color = const Color(0x12000FE2),
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  // 1、创建状态
  @override
  State<MyStatefulScaffold> createState() {
    return _MyStatefulScaffold();
  }
}

// 创建 State
class _MyStatefulScaffold extends State<MyStatefulScaffold> {
  double _size = 0;

  // 2、初始化状态
  // 在小部件创建之前和构建方法之前调用
  @override
  void initState() {
    debugPrint('--- 初始状态数据');
    super.initState();
    _size = 1.0;
  }

  // 3、当每个依赖项更改此状态时，调用此方法
  // 在构建小部件的第一次调用initState()之后，也可以立即调用它。
  @override
  void didChangeDependencies() {
    debugPrint('--- didChangeDependencies');
    super.didChangeDependencies();
  }

  // 4、当小部件重新构建时，将调用此方法。
  // 这个用于取消订阅在initState()中订阅的旧对象，
  // 并在更新的小部件配置需要替换对象时订阅新对象。
  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
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
