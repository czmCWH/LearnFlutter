/*

--- 空间缩放适配子项

👉 1、FittedBox
根据适合程度在自己体内缩放和定位其子项。

FittedBox 是一个容器，需要让其child在其范围内缩放，因此其布局行为分两种情况：
> 如果外部有约束的话，按照外部约束调整自身尺寸，然后缩放调整child，按照指定的条件进行布局；
> 如果没有外部约束条件，则跟child尺寸一致，指定的缩放以及位置属性将不起作用。

FittedBox 和 iOS 中 UIImageView 类似，即修改 contentMode 来缩放图片。

> 在 Flutter 中，子组件大小超出了父组件大小时，如果不经过处理的话 Flutter 中就会显示一个溢出警告并在控制台打印错误日志，比如下面代码会导致溢出：


 */

import 'package:flutter/material.dart';

class MyFittedBox extends StatelessWidget {
  const MyFittedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('缩放定位子项'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Row(children: [Text('xx'*30)]), //文本长度超出 Row 的最大宽度会溢出
            ),

            Container(
              color: Colors.amberAccent,
              width: 300.0,
              height: 300.0,
              child: FittedBox(
                fit: BoxFit.contain,  // 子项的缩放方式
                alignment: Alignment.topLeft, // 对齐方式
                child: Container(
                  color: Colors.red,
                  child: const Text("FittedBox"),
                ),
              ),
            )
          ],
        ));
  }
}
