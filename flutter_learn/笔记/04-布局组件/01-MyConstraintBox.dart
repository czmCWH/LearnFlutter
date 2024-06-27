/*
<https://docs.flutter.cn/ui/widgets/layout>

约束类布局容器

👉 1、ConstrainedBox
ConstrainedBox 用于对其子组件添加约束。即约束最大最小宽高。

👉 2、SizedBox
SizedBox 表示有指定大小的盒子。

SizedBox 会强制其 child 具有特定的宽/高，如果它的父级不允许这些值，这些值将被忽略。
如果没有 child，SizedBox 将在给定父项约束的情况下，尝试将自己的大小设置为尽可能接近指定的高度和宽度。
如果高度或宽度为 null 或未指定，则将被视为零。

SizedBox.expand 构造函数，将自身大小调整为适合父级。这相当于将宽度和高度设置为 double.infinity。

👉 3、UnconstrainedBox
虽然任何时候子组件都必须遵守其父组件的约束，但前提条件是它们必须是父子关系。
UnconstrainedBox 的子组件将不再受到约束，大小完全取决于自己。

在调试模式下，如果子项溢出容器，控制台上将打印警告，溢出发生的位置将出现黑色和黄色条纹区域。

👉 4、AspectRatio
AspectRatio 尝试将 child 调整为特定的宽高比。即：width:height。

👉 5、FractionallySizedBox
FractionallySizedBox 调整其 child 相对于父级宽高比。

👉 6、FittedBox
FittedBox 根据适合情况对其 child 进行缩放和定位。即在其范围内缩放定位 child 



 */

import 'package:flutter/material.dart';

class MyConstraintBox extends StatelessWidget {
  
  const MyConstraintBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('约束类布局容器'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            
            // 1、ConstrainedBox
            
            // 指定 size 约束
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: double.infinity, // 宽度尽可能大
                minHeight: 50   // 高度最小为50
              ),
              child: Container(height: 10, color: Colors.red,)
            ),
            // 指定固定的 size 约束
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 50, height: 50),
              child: Container(height: 10, color: Colors.red,)
            ),

            // 2、SizedBox
            // 限定 child 
            SizedBox(
              height: 40,
              width: 300,
              child: Container(
                color: Colors.lightBlueAccent,
                alignment: Alignment.center,
                child: const Text('天下熙熙，皆为利来；天下攘攘，皆为利往。', style: TextStyle(fontSize: 15),),
              ),
            ),
            // 没有 child，相当于分割View
            Column(
              children: [
                Container(color: Colors.red, height: 15,),
                const SizedBox(height: 10,),        // SizedBox作为分隔符
                Container(color: Colors.red, height: 15,),
              ],
            ),
            // SizedBox.expand 构造函数。
            SizedBox(
              width: 100, 
              height: 100, 
              child: SizedBox.expand(child:  Container(color: Colors.orange,),
              ),
            ),

            // UnconstrainedBox
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 200.0, minHeight: 50.0),  //父
              child: UnconstrainedBox( //去除父级限制
                alignment: Alignment.bottomLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0),//子
                  child: const DecoratedBox(decoration: BoxDecoration(color: Colors.green),),
                ),
              )
            ),

            // AspectRatio
            Container(
              color: Colors.blue,
              alignment: Alignment.center,
              width: 100.0,
              height: 100.0,
              child: AspectRatio(
                aspectRatio: 0.5,
                child: Container(
                  width: 100.0,   // 此时 width 和 heigh 设置不起作用
                  height: 50.0,
                  color: Colors.green,
                ),
              ),
            ),

            // FractionallySizedBox
            SizedBox(
              width: double.infinity,
              height: 100,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 0.5,
                alignment: FractionalOffset.bottomLeft,
                child: DecoratedBox(
                    decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 4,),
                  ),
                ),
              ),
            ),

            // FittedBox
            Container(
              height: 180,
              width: 140,
              color: Colors.red,
              child: FittedBox(
                alignment: Alignment.topLeft,
                fit: BoxFit.fitWidth,   // 以宽度为准铺满 
                clipBehavior: Clip.antiAlias,   // 高度多余的会进行裁剪
                child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),   // 高度多余的会进行裁剪
              ),
            ),

          ],
        )
      ),
    );
  }
}
