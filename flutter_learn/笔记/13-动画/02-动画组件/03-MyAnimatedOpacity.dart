import 'package:flutter/material.dart';

// AnimatedOpacity 不透明动画组件
class MyAnimatedOpacity extends StatefulWidget {
  const MyAnimatedOpacity({super.key});

  @override
  State<MyAnimatedOpacity> createState() => _MyAnimatedOpacityState();
}

class _MyAnimatedOpacityState extends State<MyAnimatedOpacity> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          child: Container(
            color: Colors.blue,
            width: 200,
            height: 200,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _opacity = _opacity == 1.0 ? 0.5 : 1.0;
            });
          }, 
          child: const Text("AnimatedOpacity"),
        ),
      ],
    );
  }
}