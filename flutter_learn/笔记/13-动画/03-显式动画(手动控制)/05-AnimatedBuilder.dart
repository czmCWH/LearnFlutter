import 'package:flutter/material.dart';

/*
  AnimatedBuilder 自定义动画
 */

class MyAnimatedBuilder extends StatefulWidget {
  const MyAnimatedBuilder({super.key});

  @override
  State<MyAnimatedBuilder> createState() => _MyAnimatedBuilderState();
}

class _MyAnimatedBuilderState extends State<MyAnimatedBuilder> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
                    duration: const Duration(seconds: 2),  // 动画时间
                    vsync: this,
                  );
    // 立即开始动画
    _controller.repeat();  
    // 监听动画
    _controller.addListener(() {
      // print("value = ${_controller.value}");
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
    final Animation opacityAnimation = Tween(begin: 0.5, end: 1.0).animate(_controller);
    final Animation heightAnimation = Tween(begin: 100.0, end: 150.0)
                                        .chain(CurveTween(curve: Curves.bounceInOut))
                                        .chain(CurveTween(curve: const Interval(0.2, 0.5)))
                                        .animate(_controller);
    return Center(
      child: Column(
        spacing: 20,
        children: [
          AnimatedBuilder(
            // animation 变化时都会执行一次 builder，从而实现动画
            animation: _controller, 
            builder: (BuildContext context, Widget? child) {
              return Opacity(
                // opacity: _controller.value,
                // opacity: Tween(begin: 0.5, end: 1.0).evaluate(_controller),
                opacity: opacityAnimation.value,
                child: Container(
                  color: Colors.blue,
                  width: 300,
                  // height: 300,
                  // height: 200 + 100*_controller.value,
                  // height: Tween(begin: 100.0, end: 300.0).evaluate(_controller),
                  height: heightAnimation.value,
                  child: child,
                ),
              );
            },
            // child 属性用于优化，它会被直接传递给 builder，在动画过程中 builder 重新绘制时并不会再次绘制 child，从而达到提升性能。
            child: const Center(
              child: Text("Hi", style: TextStyle(fontSize: 70),),
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
          )
        ],
      ),
    );
  }
}
