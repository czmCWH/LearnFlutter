/*
<https://api.flutter-io.cn/flutter/widgets/Container-class.html>
<https://www.jianshu.com/p/52bcc632d018>

---- 容器

👉 1、Container

Container 是一个便捷 Widget，它由多个负责布局、绘制、定位和调整大小的 Widget 构成。主要功能如下：

1. 尺寸控制
  - width / height，指定容器的明确的宽高，（单位：逻辑像素）。width/height 将作为约束。
  - 

container 先用 padding 包围子项，然后在填充范围内应用额外的 constraints (将宽度和高度作为约束，如果两者都非空)。
然后，cneontair 被 margin 所描述的额外空白包围。

在绘制过程中，container 首先应用给定的 transform，然后绘制 decoration 以填充填充范围，然后绘制子项，
最后绘制 foregroundDecoration，同样填充填充范围。

 */
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  
  const MyContainer({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container 容器组件'),
      ),
      body: Column(
        children: [
          // 1、alignment、decoration
          Container(
            alignment: Alignment.bottomRight,   // 子项在容器内部的对齐方式
            height: 200,
            decoration: BoxDecoration(   // 在子项背景的装饰，如背景，边框或阴影，比如：BoxDecoration、ShapeDecoration
              // color: Colors.red,     // color 会和 image 属性混合
              image: const DecorationImage(
                image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                fit: BoxFit.cover,
                opacity: 0.2,
              ),
              border: Border.all(
                color: Colors.deepOrange,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '北冥有鱼，其名为鲲。鲲之大，不知其几千里也；化而为鸟，其名为鹏。',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),

          // 2、color、padding、margin
          Container(
            color: Colors.red,    // 背景颜色 color 和 decoration 属性不能共存。
            padding: const EdgeInsets.all(10),  // 内边距：容器内补白
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // 外边距：容器外补白
            child: const Text(
              '北冥有鱼，其名为鲲。鲲之大，不知其几千里也；化而为鸟，其名为鹏。',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),

          // 3、foregroundDecoration
          Container(
            foregroundDecoration: const BoxDecoration(color: Colors.red),   // 在子项的前景装饰，会覆盖子项
            child: const Text(
              '北冥有鱼，其名为鲲。鲲之大，不知其几千里也；化而为鸟，其名为鹏。',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          
        ],
      ),
    );
  }
}
