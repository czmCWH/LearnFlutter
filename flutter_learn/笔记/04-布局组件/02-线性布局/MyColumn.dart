/* 
https://book.flutterchina.club/chapter4/row_and_column.html

👉 1、Column
Column 在垂直方向排列多个 child。

  - Column 不能滚动，如果其 children 所用空间超过 Column 的可用空间，则会报错。
  - 对于垂直方向有多个 Widget，并且希望在空间不足的时能够滚动，可使用 ListView。
  - 如果只有一个 child，可以考虑使用 Align、Center 来定位它们。

Column 的父组件的大小直接影响 Column 的最终大小和其子组件的布局行为。

 */

import 'package:flutter/material.dart';

class MyColumn extends StatelessWidget {
  
  const MyColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('线性布局'),
      ),
      body: Container(
        color: Colors.cyan,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          // 控制子组件在主轴方向（垂直方向）上的对齐方式，如：顶部对齐、居中、均匀分布
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // Column 在主轴方向占用的空间策略。.max，占满所有可用空间；.min，仅包裹子组件的内容。
          mainAxisSize: MainAxisSize.max,
          // 控制子组件在交叉轴(水平方向)上的对齐方式，如：左对齐、右对齐、拉伸填满
          crossAxisAlignment: CrossAxisAlignment.end,
          // 主轴方向上排列子组件的方向，即：down, 从上到下排列；up，从下到上排列。
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
              color: Colors.amber,
              width: 100,
              height: 100,
            ),

            Container(
              color: Colors.red[300],
              width: 200,
              height: 200,
            ),
            
            Container(
              color: Colors.blue,
              width: 300,
              height: 300,
            ),
          ],
        ),
      )
    );
  }
}
