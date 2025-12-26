import 'package:flutter/material.dart';

/*
  RotationTransition 手动控制动画旋转
  
  屏幕每次刷新时就会产生一个 Ticker，如屏幕刷新率为 60，则每秒钟会产生 60 个 Ticker。
  通过 with SingleTickerProviderStateMixin 来同步 Ticker，使得该组件可以获得 Ticker。


 */

class MyRotationTransition extends StatefulWidget {
  const MyRotationTransition({super.key});

  @override
  State<MyRotationTransition> createState() => _MyRotationTransitionState();
}

class _MyRotationTransitionState extends State<MyRotationTransition> with SingleTickerProviderStateMixin {

  // 👉 动画控制器，用于驱动、控制动画执行
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,  // 垂直同步，让动画控制器获得屏幕刷新数据
    );
    _controller.addListener(() {
      print("value = ${_controller.value}");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          RotationTransition(
            turns: _controller,
            child: const Icon(Icons.refresh, color: Colors.blue, size: 100,),
          ),
          ElevatedButton(
            onPressed: () {
              // _controller.forward();   // 向前转一圈
              // _controller.repeat();  // 一直旋转
              // _controller.reset();    // 重置
              if (_isLoading) {
                // _controller.stop();  // 立即停止
                _controller.reset();
              } else {
                _controller.repeat();
              }
              _isLoading = !_isLoading;
            }, 
            child: const Text("转动")
          ),
        ],
      ),
    );
  }
}