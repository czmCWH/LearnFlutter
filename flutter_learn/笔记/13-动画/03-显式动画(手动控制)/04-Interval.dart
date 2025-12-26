import 'package:flutter/material.dart';

/*
  基于 Interval 实现交错动画
    通过设置每个动画执行的时间段，控制动画执行的顺序。
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
                    duration: const Duration(seconds: 3),  // 动画时间
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
        children: [
          MySlidingBox(controller: _controller, color: Colors.blue[100]!, interval: const Interval(0, 0.2),),
          MySlidingBox(controller: _controller, color: Colors.blue[300]!, interval: const Interval(0.2, 0.4),),
          MySlidingBox(controller: _controller, color: Colors.blue[500]!, interval: const Interval(0.4, 0.6),),
          MySlidingBox(controller: _controller, color: Colors.blue[700]!, interval: const Interval(0.6, 0.8),),
          MySlidingBox(controller: _controller, color: Colors.blue[900]!, interval: const Interval(0.8, 1),),
          const SizedBox(height: 30,),
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

class MySlidingBox extends StatelessWidget {

  // 动画控制器
  final AnimationController controller;
  // 背景颜色
  final Color color;
  // 动画执行的时间段
  final Interval interval;

  const MySlidingBox({super.key, required this.controller, required this.color, required this.interval});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: const Offset(0.1, 0))
                  .chain(CurveTween(curve: interval))   // ⚠️，设置动画执行的时间段，从而实现交错动画。
                  .animate(controller),
      child: Container(
        color: color,
        width: 200,
        height: 80,
      ),
    );
  }
}