import 'package:flutter/material.dart';

// --- GridView.builder

/*
 gridDelegate 控制子项的布局，其的子类可为：
    SliverGridDelegateWithFixedCrossAxisCount  根据交叉轴上有固定数量来布局子项。
    SliverGridDeegateWithMaxCrossAxisExtent 根据子项在次轴方向上最大大小来布局子项。
 */

class MyGridViewBuilder extends StatelessWidget {
  const MyGridViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // gridDelegate 布局委托，用于布局子项
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 次轴上item固定数量4
        childAspectRatio: 1 / 2, // 子项宽高比为1:2，默认 1/1
        crossAxisSpacing: 10, // 次轴间距
        mainAxisSpacing: 15,  // 主轴间距
      ),  
      itemCount: 100,   // 子项个数
      itemBuilder: (BuildContext context, int index) {  // 构建子项
        return Container(
          color: Colors.blue[100],
          child: Center(
            child: Text("第${index+1}个", style: const TextStyle(color: Colors.black, fontSize: 20),),
          ),
        );
      },
    );
  }
}