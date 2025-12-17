/*
<https://api.flutter-io.cn/flutter/widgets/Container-class.html>
<https://www.jianshu.com/p/52bcc632d018>

👉 1、Container 容器

Container 是一个便捷 Widget，可以向其子 widget 增加 padding、margins、borders、background color 或者其他的“decoration 装饰”。

container 先用 padding 包围子项，然后对填充的范围应用额外的约束（如果宽度和高度中的任何一个不为空，则将其作为约束）。
然后，cneontair 被 margin 所描述的额外空白包围。

在绘制过程中，container 首先应用给定的 transform，然后绘制 decoration 以填充填充范围，然后绘制子项，
最后绘制 foregroundDecoration，同样填充填充范围。

Container 尺寸优先级： width/heigh > constraints > 父组件约束 > 自适应子组件大小


BoxDecoration 类提供了多种绘制长方体的方法。如：边框、圆角、阴影、渐变、图片填充等。

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
          // 1、padding(内边距)、margin(外边距)、color(背景色)
          Row(
            children: [
              Container(
                color: Colors.red,    // 背景颜色 color 和 decoration 属性不能共存。
                padding: const EdgeInsets.all(10),  // 内边距：容器内补白
                child: const Text(
                  '上天下地',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Container(
                color: Colors.pink, 
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // 外边距：容器外补白
                child: const Text(
                  '精通Flutter',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Container(
                color: Colors.blue,
                width: 50,
                height: 50,
              ),
            ],
          ),

          // 2、width/heigh、constraints
          Row(
            children: [
              // 2.1、指定明确的 width、height
              Container(
                alignment: Alignment.topLeft,
                color: Colors.orange,
                width: 50,
                height: 50,
              ),
              // 2.2、width、height 比 constraints 的优先级高
              Container(
                color: Colors.blue,
                width: 50,
                height: 50,
                constraints: const BoxConstraints(minWidth: 100, minHeight: 100),
              ),
              // 2.3、如果 width、height 和 constraints 都没有指定，则大小跟随子 widget
              Container(
                color: Colors.orange,
                child: Container(
                  color: Colors.blue,
                  width: 25,
                  height: 25,
                ),
              ),
              // 2.4、子组件拥有自定义大小，父组件必须设置 alignment
              Container(
                color: Colors.orange,
                width: 50,
                height: 50,
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  color: Colors.red,
                  width: 25,
                  height: 25,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                color: Colors.orange,
                width: 50,
                height: 50,
                child: Container(
                  color: Colors.blue,
                  width: 25,
                  height: 25,
                ),
              ),
              
            ],
          ),
          
          // 3、alignment 对齐方式；decoration 背景装饰，与 color 互斥。
          Container(
            alignment: Alignment.bottomLeft,   // 子项在容器内部的对齐方式
            width: 200,
            height: 200,
            decoration: BoxDecoration(   // 在子项背景的装饰，如背景，边框或阴影，比如：BoxDecoration、ShapeDecoration
              // color: Colors.red,     // color 会和 image 属性混合
              image: const DecorationImage(
                image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
              border: Border.all(
                color: Colors.deepOrange,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '这是一只猫头鹰！',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),

          // 4、foregroundDecoration 前景装饰，会覆盖子项
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            foregroundDecoration: const BoxDecoration(color: Colors.red),   // 在子项的前景装饰，会覆盖子项
            child: const Text(
              '精通Flutter',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          
          // 5、transform 变换
          Container(
            alignment: Alignment.center,
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 3,
                color: Colors.amber
              )
            ),
            transform: Matrix4.rotationZ(0.05),   // 旋转弧度
            child: const Text("Hello, Container!", style: TextStyle(color: Colors.white, fontSize: 15),),
          )

        ],
      ),
    );
  }
}