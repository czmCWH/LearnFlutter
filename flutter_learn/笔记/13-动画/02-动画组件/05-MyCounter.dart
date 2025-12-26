import 'package:flutter/material.dart';

// 防博客滚动计数器 <https://stackoverflow.com/questions/56607908/how-to-make-scrolling-counter-in-flutter>
class MyCounter extends StatefulWidget {
  const MyCounter({super.key});

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {

  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Container(
            color: Colors.blue,
            width: 300,
            height: 120,
            child: AnimatedNumber(
              value: _count, 
              duration: const Duration(milliseconds: 500),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _count++;
                  });
                }, 
                child: const Text("增加")
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _count--;
                  });
                }, 
                child: const Text("减少")
              )
            ],
          )
        ],
      ),
    );
  }
}


class AnimatedNumber extends StatelessWidget {
  
  final Duration duration;
  final int value;

  const AnimatedNumber({super.key, required this.value, required this.duration});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      tween: Tween<double>(end: value.toDouble()),
      builder:(context, value, child) {
        // 除以某个数，只取其整数部分
        final whole = value ~/ 1;
        // 获取某个数的小数部分
        final decimal = value - whole;
        return Stack(
          children: [
            Positioned(
              top: -100 * decimal,    // 0 -> -100 
              child: Opacity(
                opacity: 1 - decimal,   // 1.0 -> 0.0
                child: Text("$whole", style: const TextStyle(fontSize: 100),),
              ),
            ),
            Positioned(
              top: 100 - decimal * 100,   // 100 -> 0
              child: Opacity(
                opacity: decimal,   // 0.0 -> 1.0
                child: Text("${whole + 1}", style: const TextStyle(fontSize: 100),),
              ),
            ),
          ],
        );
      },
    );
  }
}