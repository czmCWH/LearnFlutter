/*
https://api.flutter-io.cn/flutter/widgets/Align-class.html
https://book.flutterchina.club/chapter4/alignment.html#_4-7-1-align

👉 1、Align

Align 将其子项在自己内部对齐，并根据子项的大小来调整自己的大小。

Align 的大小由如下情况决定：
  - 如果其 widthFactor、heightFactor（尺寸因子） 为 null，且尺寸受到限制，那么它会尽可能大。
  - 如果某个维度是不受约束的，并且相应的 Factor 为 null，则它在该维度上的大小与其子 Widget 的尺寸相匹配。
  - 如果 Factor 不为空，则它的 size 将是子 Widget 的尺寸与其 Factor 的乘积。

为什么 Align 的大小会有这样的行为？
  因为设置对齐方式的话，如果外层元素尺寸不确定的话，内部的对齐就无法确定。
  因此，会有宽高因子、根据外层限制扩大到最大尺寸、外层不确定时调整到child尺寸这些行为。

alignment 属性，指子组件在父组件中的起始位置。常用的子类如下：
  - Alignment 其构造器以矩形的中心点作为坐标原点，即 x=0, y=0，取值范围为：-1~1。
    - Alignment(0.0, 0)，矩形的中心点；
    - Alignment(-1.0, -1.0)，矩形的左上角；
    - Alignment(1.0, 1.0)，矩形的右下角；
  - FractionalOffset 的坐标原点为矩形的左侧顶点，x、y的取值范围是 0~1。

👉 2、Center 
Center 是 Align 的子类。
Center 与 Align 相同，但对齐方式始终设置为 Alignment.center。

总结：
  - Center 不能直接设置大小，通常取决于父 Widget 传递的约束去申请尽可能大的空间。

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 1、Align
          Row(
            children: [
              // 1、Align 的 Factor 为 null，并且尺寸受到限制，它尽可能大。如下 Align 会和父级一样大。
              Container(
                color: Colors.blue[50],
                width: 120,
                height: 120,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(color: Colors.red, width: 30, height: 30),
                ),
              ),
              // 2、Align 某个维度上没有约束，并且相应的 Factor 为 null，则它在该维度上的大小与其子 Widget 的尺寸相匹配。
              // 如下 Align 的 width 和父级一样，height 和子级一样大。
              Container(
                color: Colors.amberAccent,
                width: 120,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(color: Colors.red, width: 60, height: 60,),
                ),
              ),
            ],
          ),
          // 3、如果 Align 的 Factor 不为空，则它的 size 将是子 Widget 的尺寸与其 Factor 的乘积。
          Container(
            alignment: Alignment.center,
            color: Colors.green,
            constraints: const BoxConstraints(maxWidth: 120, maxHeight: 120),
            // width: 120,
            // height: 120,
            child: Align(
              alignment: Alignment.bottomRight,
              widthFactor: 3,
              heightFactor: 3,
              child: Container(color: Colors.red, width: 20, height: 20,),
            ),
          ),
          
          // 4、Alignment 和 FractionalOffset
          Row(
            children: [
              Container(
                color: Colors.orange,
                width: 120,
                height: 120,
                child: Align(
                  alignment: const Alignment(0, 0),    // 以左上角为坐标原点对齐
                  child: Container(color: Colors.red, width: 30, height: 30,),
                ),
              ),
              Container(
                color: Colors.greenAccent,
                width: 120,
                height: 120,
                child: Align(
                  alignment: const FractionalOffset(0, 0),    // 以左上角为坐标原点对齐
                  child: Container(color: Colors.red, width: 30, height: 30,),
                ),
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