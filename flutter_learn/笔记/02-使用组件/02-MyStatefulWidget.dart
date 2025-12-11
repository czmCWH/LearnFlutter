import 'package:flutter/material.dart';

/*
 * 定义一个有状态组件，由2个类组成： Widget组件自身 和 State
 * 1、MyStatefulWidget自身，用于对外使用，定义final 参数接收父级参数；创建 State 对象；
 * 2、State<MyStatefulWidget>，向内管理所有可变的数据和业务逻辑；实现 build 来构建UI界面；
 */
class MyStatefulWidget extends StatefulWidget {
  // 定义常量构造函数
  const MyStatefulWidget(
      {Key? key, this.color = const Color(0x12000FE2), this.child})
      : super(key: key);

  // 1、定义常量，用于接收父 Widget 传递的配置属性；在其 State 中通过 `widget.属性名` 访问
  final Color color;
  final Widget? child;

  // 2、createState，创建其 State 对象，用于存储可变状态
  @override
  State<MyStatefulWidget> createState() {
    return _MyStatefulWidgetState();
  }
}

// State 的命名为 `_` + `StatefulWidget名称` + `State`，表示一个内部类。
class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  // 2、定义动态数据
  double _size = 1.0;

  void grow() {
    // 每次调用 setState方法 都会重新运行 build
    setState(() {
      _size += 0.2;
    });
  }

  // 1、build，返回一个Widget构建UI界面；
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: grow,
      child: Container(
        // ⚠️，widget 属性用于引用其
        color: widget.color,
        child: widget.child,
        transform: Matrix4.diagonal3Values(_size, _size, 1.0),
      ),
    );
  }
}

// 使用：MyStatefulWidget(child: Text('好好学习，天天向上'),)