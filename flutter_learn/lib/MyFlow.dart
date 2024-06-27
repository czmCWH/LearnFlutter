
/* 
https://docs.flutter.cn/ui/widgets/layout
https://api.flutter-io.cn/flutter/widgets/Flow-class.html

https://book.flutterchina.club/chapter4/wrap_and_flow.html#_4-5-1-wrap

-------- 流式布局

👉 1、Flow


👉 2、Wrap


👉 3、



 */

import 'package:flutter/material.dart';


class MyFlow extends StatelessWidget {
  
  const MyFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: const Center(
        child: Text(
          '默认显示，好好学习',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
