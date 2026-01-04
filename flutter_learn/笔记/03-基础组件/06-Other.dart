import 'package:flutter/material.dart';

/*
 1、BorderSide 分割线

 2、
 
  
 */

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // 1、Divider 分割线组件
        Divider(color: Colors.white, height: 1, thickness: 0.5,),
      ],
    );
  }
}