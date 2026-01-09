import 'package:flutter/material.dart';

/*
  Widget.key 属性应用场景 - 列表项重排序时保持组件状态
    如下列表中，修改组件颜色顺序时，让组件自身状态跟随改变。

    在列表、动态 UI、动画等场景中合理使用 Key，可避免状态混乱和性能问题。

 */

class MyKeyState extends StatefulWidget {
  const MyKeyState({super.key});

  @override
  State<MyKeyState> createState() => _MyKeyStateState();
}

class _MyKeyStateState extends State<MyKeyState> {

  List<Color> colors = [Colors.red, Colors.blue];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20,
        children: [
          const Text("状态错乱"),
          Item(color: colors[0]),
          Item(color: colors[1]),
          const SizedBox(height: 40,),
          const Text("使用 key，列表项重排序时保持状态"),
          Item(key: ValueKey(colors[0]), color: colors[0]),
          Item(key: ValueKey(colors[1]), color: colors[1]),

          TextButton(
            onPressed: () {
              setState(() {
                colors = colors.reversed.toList();
              });
            }, 
            child: const Text("修改顺序")
          ),

        ],
      ),
    );
  }
}


class Item extends StatefulWidget {
  final Color color;
  const Item({super.key, required this.color});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Count: $counter'),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => setState(() => counter++),
      ),
      tileColor: widget.color,
    );
  }
}