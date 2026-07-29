/*
 👉 1、子传父 - 通过回调函数传递
  实现步骤：
    1、父组件传递一个函数给子组件；
    2、子组件调用该函数，并传递参数；
    3、父组件通过回调函数接收子组件传递的数据；

 */
import 'package:flutter/material.dart';

class MyBox extends StatefulWidget {
  const MyBox({super.key});

  @override
  State<MyBox> createState() => _MyBoxState();
}

class _MyBoxState extends State<MyBox> {

  List<String> list = ["篮球", "足球", "乒乓球", "台球", "羽毛球", "保龄球"];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(5),
      crossAxisSpacing: 20,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: List.generate(list.length, (int index) {
        return GridItem(
          title: list[index], 
          index: index, 
          delItem: (int index) {
            // ⚠️ 处理子级传递的数据，更新UI
            list.removeAt(index);
            setState(() {
              
            });
          }
        );
      }),
    );
  }
}

class GridItem extends StatefulWidget {
  // 定义 接收父级的数据
  final String title;
  final int index;

  // ⚠️，接收父级回调函数，用于向父级传递数据
  final Function(int index) delItem;

  const GridItem({super.key, required this.title, required this.index, required this.delItem});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 15),),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            onPressed: () {
              // 点击删除，调用接收 父级 的函数，并传递数据
              widget.delItem(widget.index);
            }, 
            icon: const Icon(Icons.delete, color: Colors.amber,)
          ),
        ),
      ],
    );
  }
}