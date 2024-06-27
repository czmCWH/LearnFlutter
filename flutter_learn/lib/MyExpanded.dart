/*
https://book.flutterchina.club/chapter4/row_and_column.html

-------- 弹性布局

👉 1、Expanded


👉 2、Flexible


👉 3、Spacer


 */

import 'package:flutter/material.dart';


class MyExpanded extends StatelessWidget {
  
  const MyExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: const Center(
        child: Text(
          '默认显示，好好学习',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
