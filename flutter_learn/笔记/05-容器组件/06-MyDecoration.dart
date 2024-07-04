/*

--- 容器装饰

👉 1、DecoratedBox

DecoratedBox 表示在其子绘制之前或之后绘制 装饰 的 Widget。

DecoratedBox 通常与 BoxDecoration 一起使用。

👉 2、BoxDecoration
BoxDecoration 类提供了多种绘制长方体的方法。如：边框、圆角、阴影、渐变、图片填充等。

继承关系：Object > Decoration > BoxDecoration

 */

import 'package:flutter/material.dart';

class MyDecoration extends StatelessWidget {
  
  const MyDecoration({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('装饰类'),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: const DecorationImage(
                image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(width: 8,),  // 边框宽度
              borderRadius: BorderRadius.circular(12),  // 圆角
            ),
            child: const Text('好好学习', style: TextStyle(color: Colors.red, fontSize: 28),),
          ),
        ],
      )
    );
  }
}
