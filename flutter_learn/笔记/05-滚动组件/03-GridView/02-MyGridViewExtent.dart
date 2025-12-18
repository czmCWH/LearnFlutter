import 'package:flutter/material.dart';

// --- GridView.extent 根据交叉轴方向上最大长度来决定子项的个数

class MyGridViewExtent extends StatelessWidget {
  const MyGridViewExtent({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10),  // GridView 容器本身的内边距
      maxCrossAxisExtent: 100,      // ⚠️ 必要参数，设置次轴上每个元素的最大长度。会随着屏幕的大小不同，次轴方向排列元素个数也不同。
      mainAxisSpacing: 10,
      crossAxisSpacing: 15,
      children: List.generate(100, (int index) {
        return Container(
          color: Colors.blue[100],
          child: Center(
            child: Text("第${index+1}个", style: const TextStyle(color: Colors.black, fontSize: 20),),
          ),
        );
      }),
    );
  }
}