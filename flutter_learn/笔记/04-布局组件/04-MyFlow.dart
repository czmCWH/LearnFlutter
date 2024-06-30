
/* 
https://docs.flutter.cn/ui/widgets/layout
https://api.flutter-io.cn/flutter/widgets/Flow-class.html

https://book.flutterchina.club/chapter4/wrap_and_flow.html#_4-5-1-wrap

-------- 流式布局

👉 1、Flow
Flow流式布局 根据 FlowDelegate 中的逻辑有效地调整 child 的大小和定位。

Flow布局 被优化为使用 transformation matrices 重新定位子节点。

Flow容器 的大小由委托的 FlowDelegate.getSize 函数独立于子容器。然后，根据 FlowDelegate.getConstraintsForChild 函数的约束，独立调整子级的大小。

不是在布局期间定位子项，而是在绘制阶段使用 FlowDelegate.paintChildren 函数中的 matrices 使用 transformation matrices 来定位子项。
只需重新绘制 Flow，就可以有效地重新定位子对象，而无需再次布置子对象（与 Stack 形成对比，Stack 在布局过程中一起调整大小和定位）。

触发 Flow 重绘的最有效方法是向 FlowDelegate 的构造函数提供动画。Flow 将侦听该动画，并在动画运行时重新绘制，从而避免 pipeline(管道) 的构建和布局阶段。


👉 2、Wrap
Wrap 以多个水平或垂直运行方式显示其子级的 Widget。
类似于搜索历史页面样式，一行一行摆放item，摆放不下就换行。

> 一般很少会使用 Flow，因为其过于复杂，需要自己实现子 widget 的位置转换，在很多场景下首先要考虑的是 Wrap 是否满足需求。
> Flow 主要用于一些需要自定义布局策略或性能要求较高(如动画中)的场景。

 */

import 'package:flutter/material.dart';

class MyFlow extends StatefulWidget {
  // 定义常量构造函数
  const MyFlow({ super.key });


  // 存储可变状态
  @override
  State<MyFlow> createState() {
    return _MyFlow();
  }
}

class _MyFlow extends State<MyFlow> {
  
  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('流式布局'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // 1、使用 Flow
            Flow(
              delegate: MyFlowDelegate(margin: const EdgeInsets.all(10.0)),
              children: [
                Container(color: Colors.red, width: 50, height: 50,),
                Container(color: Colors.blueAccent, width: 50, height: 70,),
                Container(color: Colors.yellow, width: 50, height: 90,),
                Container(color: Colors.red, width: 50, height: 50,),
                Container(color: Colors.blueAccent, width: 50, height: 70,),
                Container(color: Colors.yellow, width: 50, height: 90,),
              ],
            ),

            // 2、Wrap
            const Wrap(
              direction: Axis.horizontal,   // 设置主轴的方向
              verticalDirection: VerticalDirection.down,    // 交叉轴方向上排列子项的顺序和方向
              spacing: 10.0, // 主轴方向上run中的子项之间的间隔
              alignment: WrapAlignment.start,   // run 中的子项如何排列在主轴上
              runAlignment: WrapAlignment.start,    // run 本身如何放置在主轴上
              runSpacing: 0, // 在交叉轴上每行 run 之间的间距
              crossAxisAlignment: WrapCrossAlignment.end,
              children: <Widget>[
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
                  label: Text('Hamilton'),
                ),
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
                  label: Text('Lafayette'),
                ),
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('HM')),
                  label: Text('Mulligan'),
                ),
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('JL')),
                  label: Text('Laurens'),
                ),
              ],
            ),

          ],
        ),
      )
    );
  }
}


class MyFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  MyFlowDelegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定 Flow 自身的大小，简单起见我们让宽度尽可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return const Size(double.infinity, 200.0);
  }

  // true 表示需要重新绘制子元素。
  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    // 比较当前 delegate 和 oldDelegate，如果它们使得 paintChildren 的行为不同，则返回 true。
    return oldDelegate != this;
  }
}