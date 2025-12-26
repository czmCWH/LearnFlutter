import 'package:flutter/material.dart';

/*

  ScaleTransition 缩放动画

 */

class MyScaleTransition extends StatefulWidget {
  const MyScaleTransition({super.key});

  @override
  State<MyScaleTransition> createState() => _MyScaleTransitionState();
}

class _MyScaleTransitionState extends State<MyScaleTransition> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
                    duration: const Duration(seconds: 3),  // 动画时间
                    // 开始动画参数 lowerBound 会根据 duration 过渡到  开始动画参数 upperBound
                    // 并依据 _controller 传递给 Transition 处理
                    lowerBound: 1,    
                    upperBound: 2,
                    vsync: this,
                  );
    // 立即开始动画
    // _controller.repeat();  
    // 监听动画
    _controller.addListener(() {
      print("value = ${_controller.value}");
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Center(
              child: ScaleTransition(
                scale: _controller,
                // 处理在 AnimationController 初始化时通过 lowerBound、upperBound 设置动画参数值，还可以通过 Tween 参数设置
                // scale: _controller.drive(Tween(begin: 1, end: 2)),
                child: Container(
                  color: Colors.blue,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.forward();
                }, 
                child: const Text("开始动画")
              ),
              ElevatedButton(
                onPressed: () {
                  // reverse 控制动画重复时，是否可以反向执行
                  _controller.repeat(reverse: true);
                }, 
                child: const Text("重复动画")
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.reset();
                }, 
                child: const Text("重置动画")
              )
            ],
          ),
        ],
      ),
    );
  }
}

