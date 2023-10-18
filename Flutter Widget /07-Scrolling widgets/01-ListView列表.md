## ListView

[ListView](https://api.flutter-io.cn/flutter/widgets/ListView-class.html) 线性排列的可滚动小部件列表。

* `itemExtent` 将强制设置子级 `item` 在滚动方向上具有给定的范围(高度或宽度)。

* `prototypeItem` 将强制子项在滚动方向上具有与给定小部件相同的范围。

指定 `itemExtent` 或 `prototypeItem` 比让子项确定自己的范围更有效，因为滚动机制可以利用子对象范围的预知来节省工作，例如当滚动位置发生剧烈变化时；不能同时指定 `itemExtent` 和 `prototypeItem` 属性。

* 要控制滚动视图的初始滚动偏移，`controller` `ScrollController.initialScrollOffset`。***************

构建 `ListView` 有4种选项：

1、默认构造函数显式接受 `List<Widget>` 子项。此构造函数适用于具有少量子项的列表视图。

```
ListView(
  scrollDirection: Axis.vertical,   // 滚动方向
  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20), // 列表内边距
  reverse: false,    // 是否颠倒list view子项的排列方向。
  physics: const ClampingScrollPhysics(),   // list view滚动的行为，例如：不允许滚动、弹簧式滚动、无偏移式滚动。
  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,    // 滑动时关闭键盘
  // itemExtent: 80,   // 强制设置每个子项item在滚动方向的范围（宽度或高度）为80
  // prototypeItem: Container(color: Colors.red, height: 100,),   // 强制子项item的范围与prototypeItem一样
  children: [
    Container(
      height: 50,
      color: Colors.amber[600],
      child: const Center(child: Text('第一行'),),
    ),
    Container(
      height: 50,
      color: Colors.amber[300],
      child: const Center(child: Text('第二行'),),
    ),
    Container(
      height: 50,
      color: Colors.amber[100],
      child: const Center(child: Text('第三行'),),
    ),
  ],
),
```

2、`ListView.builder` 采用 `IndexedWidgetBuilder`，它根据需要构建子类。此构造函数适用于具有大量（或无限）子项的列表视图，因为只为那些实际可见的子项调用构建器。

```
class MyListViewBuildWidget extends StatefulWidget {
  const MyListViewBuildWidget({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyListViewBuildWidget();
  }
}

class _MyListViewBuildWidget extends State<MyListViewBuildWidget> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            height: 80,
            color: Colors.amber[colorCodes[index]],
            child: Center(child: Text("类型 -- ${entries[index]}"),),
          );
        }
    );
  }
}
```

3、`ListView.separated` 构造函数接受两个 `IndexedWidgetBuilders: itemBuilder`按需构建子条目，并且`separatorBuilder` 类似地构建出现在子项之间的分隔子项。这个构造函数适用于具有固定数量子项的列表视图。

```
class MyListViewSeparatedWidget extends StatefulWidget {
  const MyListViewSeparatedWidget({Key? key}): super(key: key);

  @override
  State<MyListViewSeparatedWidget> createState() {
    return _MyListViewSeparatedWidget();
  }
}

class _MyListViewSeparatedWidget extends State<MyListViewSeparatedWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 80,
            color: Colors.amber,
            child: Center(child: Text('第 $index 行'),),
          );
        },
        separatorBuilder: (BuildContext context, int index)  => const Divider(),
        itemCount: 10
    );
  }
}
```

4、`ListView.custom` 构造函数接受一个 `SliverChildDelegate`，它提供了定制子模型其他方面的能力。例如，`SliverChildDelegate`可以控制用于估计实际不可见的子项大小的算法。

```
class _ListItem extends StatelessWidget {
  final String title;

  const _ListItem({Key? key, required this.title}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        alignment: Alignment.center,
        child: Text('内容：$title'),
      ),
    );
  }
}

class MyListViewCustomWidget extends StatefulWidget {
  const MyListViewCustomWidget({Key? key}): super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return _MyListViewCustomWidget();
  }
}

class _MyListViewCustomWidget extends State<MyListViewCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      childrenDelegate: SliverChildListDelegate(
        const [_ListItem(title: "0"), _ListItem(title: "1"),],
      ),
    );
  }
}
```





