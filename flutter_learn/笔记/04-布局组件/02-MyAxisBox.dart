/* 
https://book.flutterchina.club/chapter4/row_and_column.html

-------- 线性布局

👉 1、Row
Row 水平的方式排列多个 child。无法滚动
如果要使 Widget 展开填充可用水平空间，请使用 Expanded 包装该 Widget。

👉 2、Column
Column 在垂直方向排列多个 child。无法滚动
如果要使 Widget 展开填充可用垂直空间，请使用 Expanded 包装该 Widget。

> 如果 Row、Column 只有一个 child，请使用 Align、Center 来定位它们。

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
        child: Column(
          // 主轴方向对齐方式。
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // 在主轴方向占用的空间。MainAxisSize.min表示尽可能少的占用水平空间
          mainAxisSize: MainAxisSize.max,
          // 水平方向排列 child 的方向，即：从左到右 或者 从右到左排列。
          crossAxisAlignment: CrossAxisAlignment.end,
          // 水平方向排列 child 的方向，即：从上到下 或者 从下到上。
          verticalDirection: VerticalDirection.down,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("头部 Widget"),
                Text("头部 Widget 内容"),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("好好学习"),
                Text("天天向上"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text("好好学习"),
                Text("天天向上"),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,  
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Text("尾部 Widget", style: TextStyle(fontSize: 30.0),),
                Text("尾部 Widget 内容"),
              ],
            ),
          ],
        )
      ),
    );
  }
}
