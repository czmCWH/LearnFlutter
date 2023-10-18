## Stack 叠加布局子项

[Stack](https://api.flutter.dev/flutter/widgets/Stack-class.html) 它将其子部件相对于其框的边缘进行定位。它以简单的方式重叠几个子元素。

`Stack` 的子项是 `positioned` 或者 `non-positioned`。`定位`子项是那些包装在至少具有一个非空属性的 `Positioned` 小部件中。`Stack`自身的大小包含所有 `未定位`子项，这些子项根据 `alignment ` 进行定位。

`Stack` 按顺序绘制子项，第一个子项在底部。

当使用 `Stack` 时，不能相对于子项的大小 或 `Stack`自己的大小 来定位子项。

如下绘制一个同心正方形：

```dart
class MyStackPage extends StatelessWidget {
  const MyStackPage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Stack"),),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.grey,
              height: 100,
              child: Stack(         // 绘制一个正方形同心圆
                alignment: Alignment.center,        // 设置非定位子项的对齐方式
                fit: StackFit.loose,    // 设置非定位子项的size
                children: [
                  Container(width: 100, height: 100, color: Colors.red,),
                  Container(width: 90, height: 90, color: Colors.green,),
                  Container(width: 80, height: 80, color: Colors.blueAccent,),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.lightBlueAccent,
              height: 100,
              child: Stack(     // 设置子项为定位组件
                alignment: Alignment.center,
                fit: StackFit.loose,
                clipBehavior: Clip.none,    // Positioned 溢出的不裁剪
                children: [
                  Container(width: 90, height: 90, color: Colors.red,),
                  Positioned(
                    right: -50,
                    bottom: -20,
                      child: Container(color: Colors.orange, width: 80, height: 80,)
                  ),
                ],
              ),
            ),
            Container(      // 会遮挡住Stack溢出子项
              color: Colors.green,
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
```

## IndexedStack 按索引显示叠加子项

[IndexedStack](https://api.flutter.dev/flutter/widgets/IndexedStack-class.html) 继承自 `Stack`，它只显示子项列表中的某一个子项。

`IndexedStack` 根据 `index` 属性来显示子项，如果 `index: null`则什么都不显示。

`IndexedStack` 的大小和最大的子项一样大。

```dart
class MyIndexedStackWidget extends StatefulWidget {

  const MyIndexedStackWidget({Key? key}): super(key: key);

  @override
  State<MyIndexedStackWidget> createState() {
    return _MyIndexedStackWidget();
  }
}

class _MyIndexedStackWidget extends State<MyIndexedStackWidget> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50,),
        Center(child: _buildIndexedStack(),),
        const SizedBox(height: 50,),
        _buildSwitchRow(),
      ],
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
          label: const Text('爱心'),
          onPressed: (){
            setState(() {
              _index = 0;
            });
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.phone, color: Colors.blueAccent,),
          label: const Text('电话'),
          onPressed: (){
            setState(() {
              _index = 1;
            });
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.print, color: Colors.green,),
          label: const Text('打印机'),
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
```
