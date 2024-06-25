import 'package:flutter/material.dart';

void main() {
  // runApp()函数接受给定的 Widget，并将其作为Widget树的根。
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('好好学习，天天向上'),
        ),
      ),
    );
  }
}
