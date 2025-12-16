/*
 <https://api.flutter-io.cn/flutter/widgets/Flex-class.html>
 <https://api.flutter-io.cn/flutter/widgets/Flex-class.html>

 👉 1、Flex
  Flex 是 Row、Column 父类，可以设置子组件排列放置的主轴（水平或垂直）。
  如果事先不知道主轴，可使用 Flex；否则考虑使用 Row 或 Column。
    - Flex 不能滚动，如果其子 Widget 超过可用空间，则会报错。
    - Flex 不允许子 Widget 跨多个水平或垂直方向换行。

  Flex 的子组件常使用 Expanded 或 Flexible 来控制空间的分配。
  ⚠️  Expanded 和 Flexible 只能作为 Flex（Row、Column 是 Flex 的子类） 的 child。

👉 2、Expanded
 Expanded 用于扩展 Flex（Row、Column 是 Flex 的子类) 的 child，以便该 child 填充主轴上的可用空间。

 flex属性，弹性系数：
    - 如果为 0 或null，并且 Flex 中只有一个 Expanded，则会被扩伸占用的空间。
    - 如果大于0，所有的Expanded按照其 flex 的比例来分割主轴的全部空闲空间。

👉 3、Flexible
 Flexible 是 Expanded 的父类。
 用于控制 Row、Column 或 Flex 的子级如何伸缩。与 Expanded 不同，Flexible 不需要子级填充可用空间。

  fit 属性的取值为：
    - FlexFit.tight   必须（强制）填满剩余空间。
    - FlexFit.loose   尽可能大的填满剩余空间，可以不填满。

 */

import 'package:flutter/material.dart';

class MyFlex extends StatelessWidget {
  const MyFlex({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[200],
      child: Column(
        children: [
          Flex(
            // 1、设置 Flex 主轴方向
            direction: Axis.horizontal,
            // 2、设置 Flex 的子组件之间的间隔为 20
            spacing: 20,
            children: [
              Container(
                color: Colors.red,
                width: 100,
                height: 100,
              ),
              Container(
                color: Colors.green,
                width: 100,
                height: 100,
              ),
            ],
          ),
          Flex(
            // 设置主轴方向
            direction: Axis.horizontal,
            // 3、Expanded 默认会让子 Widget 填充满可用空间
            children: [
              Expanded(
                child: Container(color: Colors.cyan, width: 100, height: 100, ),
              ),
              Container(color: Colors.pink[300], width: 100, height: 100, ),
            ],
          ),
          Flex(
            // 设置主轴方向
            direction: Axis.horizontal,
            // 4、Expanded 通过 flex 设置 蓝色占2份，红色占满1份。
            children: [
              Expanded(
                flex: 2,
                child: Container(color: Colors.cyan, width: 100, height: 100, ),
              ),
              Expanded(
                flex: 1,
                child: Container(color: Colors.pink[300], width: 100, height: 100, ),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              // 5、FlexFit.tight，完全填充满可用空间。
              Flexible(
                fit: FlexFit.tight,
                child: Container(color: Colors.purple, width: 100, height: 100,)
              ),
              //  6、FlexFit.loose，尽可能填充可用空间。
              Flexible(
                fit: FlexFit.loose,
                child: Container(color: Colors.red, width: 100, height: 100,)
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                // 7、FlexFit.tight，完全填充满可用空间
                fit: FlexFit.tight,   
                child: Container(color: Colors.cyanAccent, width: 100, height: 100,)
              )
            ],
          ),
        ],
      )
    );
  }
}