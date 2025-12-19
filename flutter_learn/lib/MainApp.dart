import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    const String appTitle = 'Material 风格的 App';

    // 一个 Material App 从 MaterialApp 小部件开始
    return MaterialApp(
      title: appTitle,  // title：窗口标题，显示在浏览器上小字。
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,   
      home: Scaffold(
        appBar: AppBar(
          title: const Text('基本组件'),
        ),
        body: const Text(""),
      ),
    );
  }
}

