## ConstrainedBox 约束子项size取值范围

[ConstrainedBox](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html) 对其子项添加额外约束的小部件。

如下固定子项的大小为 100x100：

```dart
ConstrainedBox(
  constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
  child: Container(color: Colors.red,),
),
```
如下利用 ConstrainedBox 使其子项填充其父项 Container：

```dart
Container(
  color: Colors.orange,
  constraints: const BoxConstraints(maxWidth: 100, maxHeight: 150),
  child: ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: const Card(
          color: Colors.yellow,
          child: Text(
            '北冥有鱼，其名为鲲。鲲之大，不知其几千里也；化而为鸟，其名为鹏。',
            style: TextStyle(fontSize: 15, color: Colors.black, backgroundColor: Colors.red),
          ),
      )
  ),
),
```

## SizedBox 固定子项size

[SizedBox](https://api.flutter.dev/flutter/widgets/SizedBox-class.html) 表示有指定大小的盒子。

如果 `SizeBox` 有子项，则会强制子项具有指定的宽度和高度。如果 `SizeBox` 的父级(例如：父级为屏幕、或者另一个 `SizeBox`)不允许，这些值将被忽略。

```dart
SizedBox(
  height: 40,
  width: 300,
  child: Container(
    color: Colors.lightBlueAccent,
    alignment: Alignment.center,
    child: const Text('天下熙熙，皆为利来；天下攘攘，皆为利往。', style: const TextStyle(fontSize: 15),),
  ),
)
```

如果 `SizedBox` 没有子项，则将尝试在给定父级约束的情况下尽可能接近指定的高度和宽度。

```dart
Column(
  children: [
    Container(color: Colors.red, height: 44,),
    const SizedBox(height: 10,),        // SizedBox作为分隔符
    Container(color: Colors.red, height: 44,),
  ],
)
```

`SizedBox.expand` 构造函数可用于创建一个 SizedBox，其大小适应父级。相当于将 `width` 和 `height` 设置为 `double.infinity`。

```dart
Container(
  width: 200,
  height: 200,
  child: SizedBox.expand(
    child: Container(color: Colors.lightBlueAccent,),
  ),
),
```

## AspectRatio 子项在可用范围的宽高比

[AspectRatio](https://api.flutter.dev/flutter/widgets/AspectRatio-class.html) 将它的子项的大小调整为特定宽高比。

```dart
AspectRatio(
  aspectRatio: 2/1,     // 宽度为2，高度为1
  child: Container(
    width: 100,     // 不起作用
    color: Colors.red,
  ),
)
```

## FractionallySizedBox 子项相对于父级宽高比

[FractionallySizedBox](https://api.flutter.dev/flutter/widgets/FractionallySizedBox-class.html) 将其子级大小调整为总可用空间的一小部分。

如下 `FractionallySizedBox` 将其子项 `Container` 按照宽高比例因子，和对齐方式，调整为其可用空间的大小和位置：

```dart
class MyFractionallyWidget extends StatelessWidget {
  const MyFractionallyWidget({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: FractionalOffset.center,
      widthFactor: 0.5,
      heightFactor: 0.5,
      child: Container(
        color: Colors.green,
      ),
    );
  }
}
```

## FittedBox 在其范围内缩放定位子项

[FittedBox](https://api.flutter.dev/flutter/widgets/FittedBox-class.html) 根据 `fit`(适合性) 在其内部缩放和定位其子项。

```dart
Container(
  height: 80,
  width: 140,
  color: Colors.red,
  child: FittedBox(
    alignment: Alignment.topLeft,
    fit: BoxFit.fitWidth,   // 以宽度为准铺满
    child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
    clipBehavior: Clip.antiAlias,   // 高度多余的会进行裁剪
  ),
),
```