/*
 
 👉 1、父传子 - 通过子组件构造函数传递

 实现步骤：
    1、子组件定义 final 类型属性，用于接收父组件数据；使用 final 是因为保证从父级获取数据不被随意更改。
    2、子组件在构造函数中接收数据；
    3、父组件中构造子组件时传递数据给子组件；
    4、有状态组件对外的类接收属性；对内的类通过 widget 对象获取对应属性；

 */

import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  MyBox({super.key});

  final List<String> _list = ["篮球", "足球", "乒乓球", "台球", "羽毛球", "保龄球"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[100],
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          const Text("我是父组件", style: TextStyle(color: Colors.black, fontSize: 30),), 
          // 父组件中构造子组件时，传递数据
          const MyChildStateless(messgae:  "哈哈哈",),
          // ✅ 修复：用 Expanded 包裹 GridView，给它分配可用高度
          Expanded(
            child: MyChildStatefulState(list: _list),
          ),
        ],
      ),
    );
  }
}

// 👉 1、定义无状态子组件接收父级数据
class MyChildStateless extends StatelessWidget {

  // 定义 final 属性接收 父级数据
  final String? messgae;

  const MyChildStateless({super.key, this. messgae});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets. symmetric(horizontal: 20, vertical: 10),
      child: Text("无状态子组件-$messgae", style:  const TextStyle(color: Colors. red, fontSize: 20),),
    );
  }
}

// 👉 2、定义有状态子组件接收父级数据
class MyChildStatefulState extends StatefulWidget {

  // 在外层类中定义 final 属性接收父级数据
  final List<String> list;

  const MyChildStatefulState({super.key, required this.list});

  @override
  State<MyChildStatefulState> createState() => _MyChildStatefulStateState();
}

class _MyChildStatefulStateState extends State<MyChildStatefulState> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(5),
      mainAxisSpacing: 10,
      crossAxisSpacing:  20,
      crossAxisCount: 2,
      // 在内层类中通过 widget.属性名 访问数据
      children: List. generate(widget.list.length, (int index) {
        return Container(
          color: Colors. blue,
          alignment: Alignment.center,
          child: Text(widget.list[index], style: const TextStyle(color: Colors.white, fontSize: 20),),
        );
      }),
    );
  }
}