/*
<https://pub-web.flutter-io.cn/documentation/provider/latest/provider/ValueListenableProvider-class.html>

---- 监听 ValueListenable

👉 1、ValueListenable
ValueListenable 是一个抽象类。实现类有：
Animation、RouteInformationProvider、SelectionHandler、ValueNotifier

👉 2、ValueListenableProvider
ValueListenableProvider 监听 ValueListenable 并将其结果暴露给子孙节点。并且只暴露出 ValueListenable.value。


 */

import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyValueListenableProvider(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyValueListenableProvider extends StatelessWidget {
  
  const MyValueListenableProvider({super.key, this.tipStr});

  final String? tipStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueListenableProvider'),
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
