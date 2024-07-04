/*
https://api.flutter-io.cn/flutter/widgets/Align-class.html
https://book.flutterchina.club/chapter4/alignment.html#_4-7-1-align

-------- 对齐与相对定位

👉 1、Align

Align 将其子项在自己内部对齐，并根据子项的大小来调整自己的大小。

如果 Align 的尺寸受到约束，且 widthFactor、heightFactor 为 null，则 Align 的大小尽可能大。
如果一个维度是不受约束的，并且相应的 Factor 为 null，则 Align 的大小是其 child 的大小。
如果一个维度是不受约束的，并且相应的 Factor 不为 null，则 Align 的大小是 Factor 分别乘以其 child 的宽、高；

> 为什么 Align 的大小会有这样的行为？
因为设置对齐方式的话，如果外层元素尺寸不确定的话，内部的对齐就无法确定。
因此，会有宽高因子、根据外层限制扩大到最大尺寸、外层不确定时调整到child尺寸这些行为。

alignment：表示子组件在父组件中的起始位置。常用的子类：Alignment和 FractionalOffset 表示。
  > Alignment 会以矩形的中心点作为坐标原点，即Alignment(0.0, 0.0) 。x、y的值从 -1~1 分别代表矩形 左边 > 右边 和 顶部 > 底边。
  > FractionalOffset 的坐标原点为矩形的左侧顶点，x、y的取值范围是 0~1。

👉 2、Center 
Center 是 Align 的子类。
Center 与 Align 相同，但对齐方式始终设置为 Alignment.center。



 */

import 'package:flutter/material.dart';

class MyAlign extends StatelessWidget {
  
  const MyAlign({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('对齐组件'),
      ),
      body: Column(
        children: <Widget>[
          // 1、Align
          Row(
            children: [
              const Spacer(),
              Container(
                color: Colors.blue[50],
                width: 120,
                height: 120,
                child: Align(
                  alignment: Alignment.topLeft,
                  // alignment: const Alignment(-1, 0),   // 左边中间对齐
                  child: Container(
                    color: Colors.red,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              Container(
                color: Colors.greenAccent,
                width: 120,
                height: 120,
                child: Align(
                  alignment: const FractionalOffset(1, 1),    // 以左上角为坐标原点对齐
                  child: Container(
                    color: Colors.red,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomRight,   
                // 注意：Factor 只有在 Align 没有大小约束时生效。
                widthFactor: 2,
                heightFactor: 3,
                child: FlutterLogo(size: 30,),
              ),
            ],
          ),
          
          // 2、Center
          Center(
            widthFactor: 2,
            heightFactor: 2,
            child: Container(
              color: Colors.red,
              width: 30,
              height: 30,
            ),
          ),

          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 20.0),//子
            child: const DecoratedBox(decoration: BoxDecoration(color: Colors.green),),
          ),

        ],
      ),
    );
  }
}
