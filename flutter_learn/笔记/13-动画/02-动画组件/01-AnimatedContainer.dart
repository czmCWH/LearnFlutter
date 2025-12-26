import 'package:flutter/material.dart';

// AnimatedContainer 动画盒子，修改盒子的属性时，Flutter 会自动动画渲染。
class MyAnimatedContainer extends StatefulWidget {
  const MyAnimatedContainer({super.key});

  @override
  State<MyAnimatedContainer> createState() => _MyAnimatedContainerState();
}

class _MyAnimatedContainerState extends State<MyAnimatedContainer> {

  double _height = 200;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AnimatedContainer(
            color: _color,
            width: 300,
            height: _height,
            duration: const Duration(milliseconds: 500),  // 动画持续时间
            child: const Center(
              child: Text(
                "Hi",
                style: TextStyle(fontSize: 27),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 100,
          child: TextButton(onPressed: () {
              setState(() {
                _height += 100;
                _color = Colors.red;
              });
            }, 
            child: const Text("动画")
          )
        ),
      ],
    );
  }
}