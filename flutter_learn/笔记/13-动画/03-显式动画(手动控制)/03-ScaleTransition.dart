import 'package:flutter/material.dart';

/*
  ScaleTransition 平移交互式动画 
 */

class MySlideTransition extends StatefulWidget {
  const MySlideTransition({super.key});

  @override
  State<MySlideTransition> createState() => _MySlideTransitionState();
}

class _MySlideTransitionState extends State<MySlideTransition> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
                    duration: const Duration(seconds: 1),  // 动画时间
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
              child: SlideTransition(
                position: _controller.drive(Tween(begin: const Offset(0, 0), end: const Offset(0.5, 0))),
                // position: Tween(begin: const Offset(0, 0), end: const Offset(1, 0))
                //             // .chain(Tween(begin: Offset(0.5, 0.5), end: Offset(0, 0)))
                //             .chain(CurveTween(curve: Curves.easeInCubic))
                //             .animate(_controller),
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