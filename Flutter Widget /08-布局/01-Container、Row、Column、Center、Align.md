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

