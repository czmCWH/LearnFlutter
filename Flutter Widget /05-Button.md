# Button

`flutter` 中关于 `Button` 的组件非常多，具体可看 [Buttons](https://docs.flutter.dev/development/ui/widgets/material#Buttons)

## ElevatedButton

`ElevatedButton` 用于替代老版本的 `RaisedButton`。

[ElevatedButton](https://api.flutter.dev/flutter/material/ElevatedButton-class.html) 是 `Material Design` 风格的 `Button`，一个凸起的材质矩形按钮。

`ElevatedButton`是显示在`Material`组件上的标签子级。按下按钮时，高度提升会增加。

`ElevatedButton`会为原本主要是水平布局的布局添加尺寸，例如长列表或者或在较宽的空间中。应避免在已经提升的内容(如：`dialogs`或`cards`)上使用 `ElevatedButton`。

1、通过构造方法创建一个 `ElevatedButton`：

```
ElevatedButton(
    onPressed: () {
      print("点击，on pressed");
    },
    onLongPress: () {
      print("长按，on long press");
    },
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(const TextStyle(backgroundColor: Colors.purple, fontSize: 15, )),  // 文字的背景颜色和大小
      backgroundColor: MaterialStateProperty.all(Colors.amberAccent),   // 按钮背景颜色
      foregroundColor: MaterialStateProperty.all(Colors.green),   // 文字的颜色
      overlayColor: MaterialStateProperty.all(Colors.red),    // 点击时水波纹的颜色
      // padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(20, 5, 10, 5)),  // 设置按钮child的内边距
      minimumSize: MaterialStateProperty.all(Size(50, 30)), // 按钮的最小尺寸
      alignment: Alignment.topLeft,   // 设置按钮child的对齐方式
    ),
    child: const Text('ElevatedButton'),
)
```

2、`ElevatedButton.icon` 创建一个带 `label`、`Icon`的按钮

```
ElevatedButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.search, color: Colors.yellow, size: 20,),
  label: const Text('搜索'),
  style: ElevatedButton.styleFrom(
    primary: Colors.orange, // 背景颜色
    onPrimary: Colors.green // 设置text、Icon 的颜色，text以次为主，icon以自身为主
    textStyle: const TextStyle(color: Colors.black, fontSize: 15,),
    minimumSize: Size(60, 30),
  ),
),
```

上面可以看到 `ButtonStyle` 的构造方法很复杂，`ButtonStyle.styleFrom` 是一种便捷构造方法。

如果 `onPressed` 和 `onLongPress` 回调属性为 null，则该 `ElevatedButton` 将被禁用，此时按钮呈现灰色。


## IconButton

[IconButton](https://api.flutter.dev/flutter/material/IconButton-class.html) 是 `material design` 风格的小部件。

`IconButton` 不能设置背景颜色、title标题。因为 `IconButton` 通常仅显示在父窗口小部件的背景之上。例如：[AppBar.actions](https://api.flutter.dev/flutter/material/AppBar/actions.html)


```flutter
class MyIconButtonWidget extends StatefulWidget {
  const MyIconButtonWidget({Key? key, required this.nameStr}) : super(key: key);

  final String nameStr;

  @override
  State<MyIconButtonWidget> createState() {
    // TODO: implement createState
    return _MyIconButtonWidget();
  }
}

class _MyIconButtonWidget extends State<MyIconButtonWidget> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Colors.amberAccent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            icon: const Icon(Icons.android),
            iconSize: 30,       // 需要通过 IconButton.iconSize设置Icon的大小，而不是Icon自身
            color: Colors.red,
          ),
          Text("${widget.nameStr}：$count"),
        ],
      ),
    );
  }
}

// 创建一个计数按钮
const MyIconButtonWidget(nameStr: '数量');
```


## TextButton

[TextButton](https://api.flutter.dev/flutter/material/TextButton-class.html)是 `material design` 风格的小部件，用于替代老版本的 `FlatButton`。

`TextButton` 一般在 `toolbar`、`dialogs`、或嵌入其它容器中使用，使用它的 `padding` 以便其显而易见。`TextButton`没有可见的边界，因此必须依赖其相对于其他内容的位置来确定上下文。

```Dart
TextButton(
  onPressed: () {},
  child: const Text('文本按钮'),
  style: TextButton.styleFrom(
  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
  primary: Colors.green,  // 字体颜色
  textStyle: const TextStyle(fontSize: 18),
    backgroundColor: Colors.yellow,   // 背景颜色
  ),
),
```


## OutlinedButton

[OutlinedButton](https://api.flutter.dev/flutter/material/OutlinedButton-class.html) 本质上是一个带有轮廓边框的 `TextButton`。

使用构造方法创建 `OutlinedButton`：

```Dart
OutlinedButton(
  onPressed: () {
    debugPrint('测试打印');
  },
  child: const Text('边框按钮'),
  style: OutlinedButton.styleFrom(
  primary: Colors.black,    // 文本颜色
  backgroundColor: Colors.amberAccent,    // 按钮背景颜色
  side: const BorderSide(   // 设置边框的样式
    color: Colors.cyanAccent,
    width: 2,
    style: BorderStyle.solid,
  ),
  shape: const RoundedRectangleBorder(      // 设置边框形状
    borderRadius: BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(20)),
  ),
  textStyle: const TextStyle(fontSize: 15),
  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
 ),
),
```

创建一个带文本和icon的 `OutlinedButton`：

```Dart
OutlinedButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.favorite, size: 30,),
    label: const Text('爱心'),
    style: OutlinedButton.styleFrom(
      primary: Colors.red,
      backgroundColor: Colors.grey,
      
    ),
),
```


