/* 
https://book.flutterchina.club/chapter4/row_and_column.html

线性布局

👉 1、




 */

import 'package:flutter/material.dart';


class MyAxisBox extends StatelessWidget {
  
  const MyAxisBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('线性布局'),
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
