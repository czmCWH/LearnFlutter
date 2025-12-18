/*
<https://api.flutter-io.cn/flutter/widgets/BoxScrollView-class.html>
<https://api.flutter-io.cn/flutter/widgets/SingleChildScrollView-class.html>

👉 1、SingleChildScrollView 滚动框
一个可以滚动显示单个控件的框。它通常接收一个 ListBody 或 Column 来容纳多个 Widget。

SingleChildScrollView 会一次性构建所有子组件，如果组件过多请使用 ListView


primary属性：
  它表示是否使用 widget 树中默认的 PrimaryScrollController（MaterialApp 组件树中已经默认包含一个 PrimaryScrollController 了）
  当滑动方向为垂直方向（scrollDirection值为Axis.vertical）并且没有指定 controller 时，primary 默认为 true。

 */

import 'package:flutter/material.dart';

class MySingleChildScrollView extends StatefulWidget {

  const MySingleChildScrollView({ super.key});

  @override
  State<MySingleChildScrollView> createState() {
    return _MySingleChildScrollView();
  }
}

class _MySingleChildScrollView extends State<MySingleChildScrollView> {

  // 1、滚动条控制器，控制 SingleChildScrollView 滚动
  late final ScrollController _controller = ScrollController();
 
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,   // 滑动方向
          padding: const EdgeInsets.all(10),
          physics: const BouncingScrollPhysics(),
          controller: _controller,
          child: Column(
            children: List.generate(6, (index) {
              return Container(
                alignment: AlignmentGeometry.center,
                width: double.infinity,
                height: 50*(index + 1),
                color: Colors.primaries[index % Colors.primaries.length],
                child: Text("第${index + 1}个子组件", style: const TextStyle(color: Colors.white),),
              );
            }).toList(),
          ),
        ),
        Positioned(
          right: 20,
          top: 20,
          width: 80,
          height: 80,
          child: TextButton(
            onPressed: () {
              // 滚动到顶部，没有动画
              // _controller.jumpTo(0);
              // 以动画方式滚动到顶部
              _controller.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
            }, 
            style: TextButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
            ),
            child: const Text("顶部"),
          )
        ),
        Positioned(
          right: 20,
          bottom: 20,
          width: 80,
          height: 80,
          child: TextButton(
            onPressed: () {
              // 滚动到底部
              // _controller.jumpTo(_controller.position.maxScrollExtent);
              // 以动画方式滚动到底部
              _controller.animateTo(
                _controller.position.maxScrollExtent, 
                duration: const Duration(milliseconds: 200), 
                curve: Curves.easeIn
              );
            }, 
            style: TextButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
            ),
            child: const Text("底部"),
          )
        ),
      ],
    );
  }
}
