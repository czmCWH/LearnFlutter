import 'package:flutter/material.dart';
import 'MyScaffold.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: Flutter2jsByUrl(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}