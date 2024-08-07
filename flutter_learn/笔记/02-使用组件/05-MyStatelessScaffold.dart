import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyStatelessScaffold(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyStatelessScaffold extends StatelessWidget {
  
  const MyStatelessScaffold({super.key, this.tipStr});

  final String? tipStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: Center(
        child: Text(
          tipStr ?? '默认显示，好好学习',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
