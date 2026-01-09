import 'package:flutter/material.dart';

/*
  ReorderableListView 实现拖动排序，指定 UniqueKey
 */

class MyOrderList extends StatefulWidget {
  const MyOrderList({super.key});

  @override
  State<MyOrderList> createState() => _MyOrderListState();
}

class _MyOrderListState extends State<MyOrderList> {

  final boxes = [
    Box(key: UniqueKey(), color: Colors.blue[100]!),
    Box(key: UniqueKey(), color: Colors.blue[300]!),
    Box(key: UniqueKey(), color: Colors.blue[500]!),
    Box(key: UniqueKey(), color: Colors.blue[700]!),
    Box(key: UniqueKey(), color: Colors.blue[900]!),
  ];

  // 打乱数组元素顺序
  void _shuffle() {
    setState(() {
      boxes.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ReorderableListView(
        children: boxes,   
        onReorder: (int oldIndex, int newIndex) {
          if (newIndex > oldIndex) {    // 避免向下拖动 crash
            newIndex--;
          }
          final box = boxes.removeAt(oldIndex);
          boxes.insert(newIndex, box);
        }
      ),
    );
  } 
}

class Box extends StatelessWidget {
  final Color color;
  const Box({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 50,
      height: 50,
    );
  }
}