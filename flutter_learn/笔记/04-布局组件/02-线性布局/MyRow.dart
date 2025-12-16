/* 
https://book.flutterchina.club/chapter4/row_and_column.html

👉 1、Row
Row 水平的方式排列多个 child。

  - Row 的特点和 Column 基本一致，它也是无法滚动。

> 如果 Row、Column 只有一个 child，请使用 Align、Center 来定位它们。

 */

import 'package:flutter/material.dart';

class MyRow extends StatelessWidget {
  const MyRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: Row(
        // 控制子组件在主轴（水平方向）上的排列方式，如：左对齐、右对齐、环绕、居中
        mainAxisAlignment: MainAxisAlignment.end,
        // 控制 Row自身在水平方向的尺寸策略，max，占满全部；min，仅仅包裹子组件的内容；
        mainAxisSize: MainAxisSize.min,
        // 控制子组件在交叉轴（垂直方向）的对齐方式，如：顶部对齐、底部对齐、
        crossAxisAlignment: CrossAxisAlignment.center,
        // 主轴方向上排列子组件的方向，即：down, 从左到右依次排列；up，从右到左依次排列。
        verticalDirection: VerticalDirection.down,
        children: [
          Container(
            color: Colors.red,
            width: 50,
            height: 50,
          ),
          Container(
            color: Colors.amber,
            width: 100,
            height: 100,
          ),
          Container(
            color: Colors.green,
            width: 80,
            height: 80,
          )
        ],
      ),
    );
  }
}