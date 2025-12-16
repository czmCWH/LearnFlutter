/*
 👉 1、Spacer
 Spacer 是在 Flex（Row/Column）内用于分配剩余主轴空间的空白占位 widget。
  
    - flex 属性，用于表示在分配剩余空间时占的比例。

 由于 Spacer 将占用任何可用空间，因此将包含 Spacer 的 Flex 容器上的 mainAxisAlignment 设置为
 .spaceAround、.spaceBetween、.spaceEvenly 时，这些属性将不会产生任何可见效果。
 
 */

import 'package:flutter/material.dart';

class MySpacer extends StatelessWidget {
  const MySpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(color: Colors.amber, width: 100, height: 100,),
            Container(color: Colors.cyan, width: 100, height: 100,),
            Container(color: Colors.blue, width: 100, height: 100,),
          ],
        ),
        const Spacer(),
        // 1、Spacer 分配剩余主轴空间的空白占位 widget。
        Row(
          children: [
            Container(color: Colors.amber, width: 100, height: 100,),
            const Spacer(),
            Container(color: Colors.cyan, width: 100, height: 100,),
            const Spacer(),
            Container(color: Colors.blue, width: 100, height: 100,),
          ],
        ),
        const Spacer(),
        // 由于使用了 Spacer，所以 mainAxisAlignment 不会有任何效果
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(color: Colors.amber, width: 100, height: 100,),
            const Spacer(flex: 1,),
            Container(color: Colors.cyan, width: 100, height: 100,),
            const Spacer(flex: 3,),
            Container(color: Colors.blue, width: 100, height: 100,),
          ],
        ),
        const Spacer(flex: 3,),
      ],
    );
  }
}