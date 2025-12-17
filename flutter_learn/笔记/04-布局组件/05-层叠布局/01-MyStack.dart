/*
<https://api.flutter-io.cn/flutter/widgets/Stack-class.html>

👉 1、Stack
 Stack 是用于在同一“平面”上堆叠多个子 Widget 的容器。
 Stack 中的子组件，用 Positioned 包裹的称为 positioned 组件，其它组件称为 non-positioned 组件。

Stack 大小会根据自身大小调整，以容纳所有 non-positioned 子元素，这些子元素会根据 alignment 属性进行层叠排放。
而 positioned 子元素根据其top, right, bottom, left 属性相对于 Stack 进行摆放，从而实现绝对定位。

在使用堆栈时，无法根据子元素的大小或 Stack 自身的大小来定位子元素。
如果要在一个特定的模式中布局一些子节点，或者想做一个自定义布局管理器，需要用 CustomMultiChildLayout 来代替 Stack。

 */

import 'package:flutter/material.dart';

class MyStack extends StatelessWidget {
  const MyStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[200],
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        // alignment 用于指定 non-positioned 子组件如何层叠摆放
        alignment: AlignmentDirectional.center,
        // fit 用于控制 non-positioned 子组件如何适应 Stack 的尺寸
        fit: StackFit.loose,
        children: [

          // 1、non-positioned 组件根据 alignment 属性、添加顺序进行层叠摆放
          // 如下，在 Stack 中居中层叠摆放一个同心正方形
          Container(width: 300, height: 300, color: Colors.red,),
          Container(width: 200, height: 200, color: Colors.blue,),
          Container(width: 100, height: 100, color: Colors.orange,),
          Container(width: 50, height: 50, color: Colors.green,),

          // 2、positioned 组件根据其top、left、right、bottom属性在 Stack 中进行绝对定位
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(width: 50, height: 50, color: Colors.green,),
          ),
          
          // 3、positioned 组件的top、left、right、bottom属性都为0时，其子组件会拉伸填充满 Stack
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: Container(width: 50, height: 50, color: Colors.green,),
          // ),
        ],
      ),
    );
  }
}
