import 'package:flutter/material.dart';

// TweenAnimationBuilder -- 万能的补间动画
class MyTweenAnimationBuilder extends StatefulWidget {
  const MyTweenAnimationBuilder({super.key});

  @override
  State<MyTweenAnimationBuilder> createState() => _MyTweenAnimationBuilderState();
}

class _MyTweenAnimationBuilderState extends State<MyTweenAnimationBuilder> {

  double _end = 20;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 20, end: _end), 
            duration: const Duration(seconds: 2), 
            curve: Curves.bounceInOut,
            builder: (context, value, widget) {
              return Container(
                color: Colors.blue,
                width: 300,
                height: 300,
                alignment: Alignment.center,
                child: Text("Hi", style: TextStyle(fontSize: value),),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _end = _end == 20 ? 100 : 20;
              }); 
            }, 
            child: const Text("动画文字大小"),
          ),
        ],
      ),
    );
  }
}
