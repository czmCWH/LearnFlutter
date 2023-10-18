## Container

[Container](https://api.flutter.dev/flutter/widgets/Container-class.html) 

`container` 先用 `padding` 包围子项，然后对填充范围应用额外的 `constraints` (将宽度和高度作为约束，如果两者都非空)。然后，`container`被 `margin` 所描述的额外空白包围。

在绘制过程中，`container` 首先应用给定的 `transform`，然后绘制 `decoration` 以填充填充范围，然后绘制子项，最后绘制 `foregroundDecoration`，同时填充填充范围。

```dart
Container({
  Key? key,
  this.alignment,       // 子项在容器内部的对齐方式
  this.padding,         // 子项的内边距
  this.color,           // 背景颜色，color 和 decoration 属性不能共存。
  this.decoration,      // 在子项背景的装饰，比如：BoxDecoration、ShapeDecoration
  this.foregroundDecoration,    // 在子项的前景装饰，会覆盖子项
  double? width,        
  double? height,
  BoxConstraints? constraints,      // 对子项的约束
  this.margin,      // 外边距
  this.transform,       // 变换
  this.transformAlignment,      // 指定了 transform 时，相对于容器大小的原点对齐方式。
  this.child,
  this.clipBehavior = Clip.none,        // decoration不为null时，裁剪。
})
```

没有子项的 `container` 会尽量大。如果传入的 `constraints`(约束) 是无限的，在这种情况下，它们会尽量小。有子项的 `container` 会根据子项的大小调整自己的大小。构造函数的`width`、`height` 和 `constraints`参数会覆盖它。

```dart
Container(
  alignment: Alignment.topLeft,
  padding: const EdgeInsets.all(10),
  margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
  // color: Colors.deepOrange,
  width: 100,
  height: 100,
  child: const Text(
    '北冥有鱼，其名为鲲。鲲之大，不知其几千里也；化而为鸟，其名为鹏。',
    style: TextStyle(color: Colors.black, fontSize: 15),
  ),
  decoration: BoxDecoration(
    // color: Colors.red,     // color 会和 image 属性混合
    image: const DecorationImage(
      image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
      fit: BoxFit.cover,
      opacity: 0.2,
    ),
    border: Border.all(
      color: Colors.deepOrange,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
)
```

* 当 `width`和 `height` 和 `constraints` 同时不为 `null` 时，`Container` 尝试尽可能小。

* `alignment` 和 `child` 属性是否为 `null` 对 `constraints` 有影响。

当 `alignment` 为 `null`，`child` 和 `constraints` 时，`child` 会自动调整到适合的大小。

```dart
Container(
  // alignment: Alignment.topLeft,
  padding: const EdgeInsets.all(5),
  margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
  color: Colors.deepOrange,
  child: const Text(
    '北冥有鱼，其名为鲲。鲲之大，不知其几千里也；化而为鸟，其名为鹏。',
    style: TextStyle(color: Colors.black, fontSize: 15),
  ),
  constraints: const BoxConstraints(maxWidth: 100),
)
```

设置旋转弧度：

```dart
Container(
  padding: const EdgeInsets.all(5),
  margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
  color: Colors.deepOrange,
  child: const Text(
    '北冥有鱼，其名为鲲。鲲之大，不知其几千里也；化而为鸟，其名为鹏。',
    style: TextStyle(color: Colors.black, fontSize: 15),
  ),
  constraints: const BoxConstraints(maxWidth: 100),
  transform: Matrix4.rotationZ(0.1),    // 旋转弧度
)
```

详细Api介绍也可以学习 [简书博客: maskerII](https://www.jianshu.com/p/52bcc632d018)


## Row

[Row](https://api.flutter.dev/flutter/widgets/Row-class.html) 可以沿水平方向排列其子widget。`Row` 的子项不允许滚动。如果您有一行小部件并希望它们能够在空间不足时滚动，请考虑使用 `ListView`。

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,    // 当 mainAxisSize = MainAxisSize.max 时，mainAxisAlignment 属性的值才有意义。
  mainAxisSize: MainAxisSize.max,   // 在主轴(水平)方向占用的空间。MainAxisSize.min表示尽可能少的占用水平空间
  crossAxisAlignment: CrossAxisAlignment.end,   // 每个子项在纵轴方向的对齐方式。如：.end：顶部对齐
  verticalDirection: VerticalDirection.down,    // 交叉轴方向，它会影响 crossAxisAlignment 属性。如：从上到下 或者 从下到上。
  children: [
    Container(
      height: 100,
      width: 100,
      color: Colors.orange,
    ),
    Container(
      height: 50,
      width: 100,
      color: Colors.red,
    )
  ],
)
```

当 `Row` 的子项由 `Expanded` 包装时，其子项会展开以填充可用的水平空间。

```dart
Row(
  children: [
    Expanded(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.orange,
        )
    ),
    Container(
      height: 100,
      width: 100,
      color: Colors.red,
    )
  ],
),
```


## Column 

[Column](https://api.flutter.dev/flutter/widgets/Column-class.html) 在垂直方向上排列其子项数组。它的的功能和 `Row` 完全一致。

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  mainAxisSize: MainAxisSize.max,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      color: Colors.orange,
      width: 100,
      height: 100,
    ),
    Container(
      color: Colors.red,
      width: 100,
      height: 100,
    )
  ],
),
```

## Center 和 Align 

[Center](https://api.flutter.dev/flutter/widgets/Center-class.html) 以自身为中心的组件。

```dart
class MyCenterPage extends StatelessWidget {
  const MyCenterPage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Center Widget'),),
        body: Container(
          color: Colors.orange,
          width: 200,
          height: 200,
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Center(
                widthFactor: 0.5,     // 宽度因子，默认为1.0。Center组件的宽度 = 宽度因子 * 子项宽度
                child: Text('Text'),
              ),
              Container(
                color: Colors.teal,
                width: 50,
                height: 50,
              )
            ],
          )
        ),
      ),
    );
  }
}
```

[Align](https://api.flutter.dev/flutter/widgets/Align-class.html) 将其子部件与自身对齐，并根据子部件的大小选择调整自身大小。

```dart
Container(
  color: Colors.teal,
  width: 100,
  height: 100,
  child: const Align(
    alignment: Alignment(0.2, 0.6),
    widthFactor: 1.0,
    heightFactor: 1.0,
    child: FlutterLogo(size: 30,),
  ),
)
```

