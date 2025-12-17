/*
<https://api.flutter-io.cn/flutter/widgets/IndexedStack-class.html>

 👉 1、IndexedStack
  IndexedStack 根据其 index 属性来显示子项列表的某一个子项。如果 index 为 null，则 IndexedStack 不显示任何内容。

  > IndexedStack 的大小和最大的子项一样大。

 */
import 'package:flutter/material.dart';

class MyIndexedStack extends StatefulWidget {
  const MyIndexedStack({super.key});

  @override
  State<MyIndexedStack> createState() => _MyIndexedStackState();
}

class _MyIndexedStackState extends State<MyIndexedStack> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildIndexedStack(),
        const SizedBox(height: 50,),
        _buildSwitchRow(),
      ],
    );
  }

  IndexedStack _buildIndexedStack() {
    return IndexedStack(
      // alignment 属性用于调整层叠子组件在 IndexedStack 中的对齐方式
      alignment: AlignmentDirectional.center,
      // index 属性用于显示某个层叠的子组件，而其它索引的子组件被隐藏
      index: _index,
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