import 'package:flutter/material.dart';

/*
 
 478呼吸法动画案例

 */
class MyBreatheAnimate extends StatefulWidget {
  const MyBreatheAnimate({super.key});

  @override
  State<MyBreatheAnimate> createState() => _MBbreatheStateAnimate();
}

class _MBbreatheStateAnimate extends State<MyBreatheAnimate> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 20),
      );
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

    // 478呼吸法：4秒吸气、7秒屏住呼吸、8秒呼气  4+7+8 = 19秒 1秒休息时间

    // 使用交错式动画

    // 4秒吸气
    Animation animation1 = Tween(begin: 0.0, end: 1.0)
                              .chain(CurveTween(curve: const Interval(0.0, 0.2)))   // 0秒 到 4/20秒
                              .animate(_controller);
    // 8秒呼气
    Animation animation3 = Tween(begin: 1.0, end: 0.0)
                              .chain(CurveTween(curve: const Interval(0.55, 0.95)))   // 11/20秒 到 19/20秒
                              .animate(_controller);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller, 
            builder: (context, child) {
              return Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  gradient: RadialGradient(
                    colors: [Colors.blue[600]!, Colors.blue[100]!],
                    stops: _controller.value <= 0.2 
                          ? [animation1.value, animation1.value + 0.1]
                          : [animation3.value, animation3.value + 0.1],
                  ),
                ),
              );
            }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.repeat(reverse: true);
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