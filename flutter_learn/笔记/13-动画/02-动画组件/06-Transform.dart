import 'package:flutter/material.dart';

class MyTweenAnimationBuilder extends StatefulWidget {
  const MyTweenAnimationBuilder({super.key});

  @override
  State<MyTweenAnimationBuilder> createState() => _MyTweenAnimationBuilderState();
}

class _MyTweenAnimationBuilderState extends State<MyTweenAnimationBuilder> {

  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 1, end: _big ? 3 : 1), 
            duration: const Duration(seconds: 1), 
            curve: Curves.easeInOut,
            builder: (context, value, widget) {
              return Container(
                color: Colors.blue,
                width: 300,
                height: 300,
                alignment: Alignment.center,
                // Transform(transform: ) 可以直接实现 平移/旋转/缩放。它也提供了如下便利函数：
                // Transform.(translate/rotate/scale)，平移/旋转/缩放，3个函数
                child: Transform.scale(
                  scale: value,
                  child: const Text("Hi", style: TextStyle(fontSize: 72),),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _big = !_big;
              }); 
            }, 
            child: const Text("动画文字大小"),
          ),
        ],
      ),
    );
  }
}