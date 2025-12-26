import 'package:flutter/material.dart';

/*
  478呼吸法动画
 */

class MyBreatheAnimate extends StatefulWidget {
  const MyBreatheAnimate({super.key});

  @override
  State<MyBreatheAnimate> createState() => _MBbreatheStateAnimate();
}

class _MBbreatheStateAnimate extends State<MyBreatheAnimate> with TickerProviderStateMixin {

  // AnimationController 执行动画时，其 .value 属性会按 0->1 的变化传递给 AnimatedBuilder 组件
  late final AnimationController _expansionController;
  late final AnimationController _opacityController;

  @override
  void initState() {
    // TODO: implement initState
    // ⚠️，当存在2个 Controller 时，不能用 SingleTickerProviderStateMixin 而需要用 TickerProviderStateMixin
    _expansionController = AnimationController(vsync: this,);
    _opacityController = AnimationController(vsync: this,);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _expansionController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // 478呼吸法：4秒吸气、7秒屏住呼吸、8秒呼气  4+7+8 = 19秒 1秒休息时间

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: Tween(begin: 1.0, end: 0.5).animate(_opacityController),
            child: AnimatedBuilder(
              animation: _expansionController, 
              builder: (context, child) {
                return Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    gradient: RadialGradient(
                      colors: [Colors.blue[600]!, Colors.blue[100]!],
                      stops:[_expansionController.value, _expansionController.value + 0.1]  
                    ),
                  ),
                );
              }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  _expansionController.duration = const Duration(seconds: 4);
                  _expansionController.forward();
                  
                  await Future.delayed(const Duration(seconds: 4));   // 4秒等待动画执行

                  _opacityController.duration = const Duration(milliseconds: 1750);   // 7000/4
                  _opacityController.repeat(reverse: true);

                  await Future.delayed(const Duration(seconds: 7));   // 7秒保持不动，表示屏住呼吸7秒
                  _opacityController.reset();

                  _expansionController.duration = const Duration(seconds: 8);
                  _expansionController.reverse();
                }, 
                child: const Text("开始动画")
              ),
            ],
          )
        ],
      ),
    );
  }
}
