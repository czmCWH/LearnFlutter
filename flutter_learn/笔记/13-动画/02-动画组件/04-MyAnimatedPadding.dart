import 'package:flutter/material.dart';

// AnimatedPadding
class MyAnimatedPadding extends StatefulWidget {
  const MyAnimatedPadding({super.key});

  @override
  State<MyAnimatedPadding> createState() => _MyAnimatedPaddingState();
}

class _MyAnimatedPaddingState extends State<MyAnimatedPadding> {

  double _left = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPadding(
          padding: EdgeInsets.only(left: _left), 
          duration: const Duration(seconds: 2),
          // 👉 curve 动画曲线，<https://api.flutter.dev/flutter/animation/Curves-class.html>
          curve: Curves.bounceInOut,
          child: Container(
            color: Colors.amber,
            width: 100,
            height: 100,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _left += 100;
            });
          }, 
          child: const Text("AnimatedPadding"),
        )
      ],
    );
  }
}