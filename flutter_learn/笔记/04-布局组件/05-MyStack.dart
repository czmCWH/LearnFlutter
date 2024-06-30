/*
-------- 层叠布局

👉 1、Stack
Stack 和 Positioned 配合实现绝对定位。Stack 使得子项堆叠，Positioned 用于根据Stack的四个角来确定子组件的位置。

Stack 的子项是 positioned 或者 non-positioned。
Positioned children 是那些包装在至少有一个非空属性的 Positioned widget 中的元素。
Stack 本身的大小包含所有 non-positioned children，这些 children 根据对齐方式进行定位(在从左到右的环境中默认为左上角，在从右到左的环境中则默认为右上角）。然后根据它们的top、right、bottom 和 left 属性相对于 Stack 放置定位的子元素。

如果要在一个特定的模式中布局一些子节点，或者想做一个自定义布局管理器，需要用 CustomMultiChildLayout 来代替 Stack。
特别是，当使用 Stack 时，不能相对于它们的大小或堆栈本身的大小定位子节点。


👉 2、IndexedStack
IndexedStack 根据其 index 属性来显示子项列表的某一个子项。如果 index 为 null，则 IndexedStack 不显示任何内容。

> IndexedStack 的大小和最大的子项一样大。

 */
import 'package:flutter/material.dart';

class MyStack extends StatefulWidget {
  // 定义常量构造函数
  const MyStack({ super.key});

  // 存储可变状态
  @override
  State<MyStack> createState() {
    return _MyStack();
  }
}

class _MyStack extends State<MyStack> {

  int _index = 0;

  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('层叠布局'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // 1、Stack 绘制一个正方形同心圆
            Stack(        
              alignment: Alignment.center,        // 设置没有使用 Positioned 的子项 或者 部分定位widget 的对齐方式
              fit: StackFit.loose,    // 设置 没有使用 Positioned 的子项 如何去适应 Stack 的大小
              clipBehavior: Clip.hardEdge,  // 对超出Stack显示空间的部分如何剪裁
              children: [
                Container(width: 100, height: 100, color: Colors.red,),
                Container(width: 90, height: 90, color: Colors.green,),
                Container(width: 80, height: 80, color: Colors.blueAccent,),
              ],
            ),

            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 100),
              child: Stack(
                alignment: Alignment.center ,  //指定 未定位 或 部分定位widget 的对齐方式
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    child: const Text("Hello world", style: TextStyle(color: Colors.white)),
                  ),
                  const Positioned(left: 18.0, child: Text("我显示在左边"),
                  ),
                  const Positioned(bottom: 10, child: Text("受到 Stack 的 alignment 属性影响 "),)        
                ],
              ),
            ),
            
            // 2、IndexedStack
            const SizedBox(height: 50,),
            Center(child: _buildIndexedStack(),),
            const SizedBox(height: 50,),
            _buildSwitchRow(),

          ],
        ),
      ),
    );
  }


  IndexedStack _buildIndexedStack() {
    return IndexedStack(
      index: _index,
      alignment: Alignment.center,
      children: [
        Container(width: 200, height: 200, color: Colors.red,),
        Container(width: 150, height: 150, color: Colors.blue,),
        Container(width: 100, height: 100, color: Colors.green,),
      ],
    );
  }

  Row _buildSwitchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.favorite, color: Colors.red,),
          label: const Text('子项1'),
          onPressed: (){
            setState(() {
              _index = 0;
            });
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.phone, color: Colors.blueAccent,),
          label: const Text('子项2'),
          onPressed: (){
            setState(() {
              _index = 1;
            });
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.print, color: Colors.green,),
          label: const Text('子项3'),
          onPressed: (){
            setState(() {
              _index = 2;
            });
          },
        ),
      ],
    );
  }



}
