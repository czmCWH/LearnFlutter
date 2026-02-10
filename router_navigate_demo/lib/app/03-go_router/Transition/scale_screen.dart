import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaleScreen extends StatelessWidget {
  const ScaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("页面转场动画"),),
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            ElevatedButton(
              onPressed: () {
                context.pop();
              }, 
              child: Text("关闭页面")
            ),
          ],
        ),
      ),
    );
  }
}