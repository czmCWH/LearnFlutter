/*
https://book.flutterchina.club/chapter4/row_and_column.html

-------- 弹性布局

👉 1、Expanded
Expanded 用于扩展 Flex（Row、Column 是 Flex 的子类) 的 child，以便该 child 填充主轴上的可用空间。

*  flex 参数为弹性系数，如果为 0 或null，则child是没有弹性的，即不会被扩伸占用的空间。
        如果大于0，所有的Expanded按照其 flex 的比例来分割主轴的全部空闲空间。
* Expanded 继承自 Flexible

👉 2、Flexible
用于控制 Row、Column 或 Flex 的子级如何伸缩。
与 Expanded 不同，Flexible 不需要子级填充可用空间。

* fit 参数：
  FlexFit.tight   必须（强制）填满剩余空间
  FlexFit.loose   尽可能大的填满剩余空间，但是可以不填满，即可以遵循child自身的大小。

> 注意：
>     Expanded 和 Flexible 只能作为 Flex（Row、Column 是 Flex 的子类） 的 child。
>     从 Expanded、Flexible 到其封闭的 Flex 的路径必须只包含 StatelessWidgets 或 statfulwidgets(不包含其他类型，如 RenderObjectWidgets)。

👉 3、Spacer
Spacer 创建一个可调整的空间隔，可用于调整 Flex 容器（如 Row、Column）中小部件之间的间距。

由于 Spacer 将占用任何可用空间，因此将包含 Spacer 的 Flex 容器上的 mainAxisAlignment 设置为
MainAxisAlignment.spaceAround、MainAxisAlignment.spaceBetween、MainAxisAlignment.spaceEvenly
将不会产生任何可见效果。


 */

import 'package:flutter/material.dart';


class MyExpanded extends StatelessWidget {
  
  const MyExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child:  Container(color: Colors.blue, width: 100, height: 50,),   // 设置 width 不生效
                ),
                Expanded(
                  flex: 1,
                  child: Container(color: Colors.amber, height: 100, ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(color: Colors.blue, width: 100, height: 50,),    // 设置 width 生效
                ),
                Flexible(
                  flex: 3,
                  child: Container(color: Colors.orange, height: 50,),
                ),
              ],
            ),
            const Spacer(flex: 1,),
            Row(
              children: [
                Container(color: Colors.blue, width: 100, height: 50,), 
              ],
            ),
            const Spacer(flex: 5,),
          ],
        ),
      ),
    );
  }
}
