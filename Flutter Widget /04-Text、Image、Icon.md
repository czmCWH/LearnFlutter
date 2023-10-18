## Text

[Text class](https://api.flutter.dev/flutter/widgets/Text-class.html)表示单一样式的文本。

```Dart
Text(
    "北冥有鱼，其名为鲲。鲲之大，不知其几千里也。化而为鸟，其名为鹏。鹏之背，不知其几千里也；怒而飞，其翼若垂天之云。是鸟也，海运则将徙于南冥。南冥者，天池也。",
    style: TextStyle(
      color: Colors.yellow,   // 字体颜色
      backgroundColor: Colors.blue,   // 文本背景色
      fontSize: 18,   // 字体大小
      fontStyle: FontStyle.normal,
      shadows: [
        Shadow(color: Colors.red, offset: Offset(3, 5), blurRadius: 6)
      ],
      decoration: TextDecoration.overline,   // 设置下划线
    ),
    textAlign: TextAlign.left,  // 对齐方式
    overflow: TextOverflow.ellipsis,  // 文本溢出时末尾样式 ellipsis：末尾点点显示
    maxLines: 3,  // 最多显示行数
),
```

`Text.rich(...)` 构造函数，用于创建不同样式`TextSpan`的段落。

```Dart
Text.rich(
  TextSpan(
    text: "朝辞白帝彩云间，",   // 默认文本样式
    style: TextStyle(color: Colors.black),
    children: <TextSpan>[
        TextSpan(
          text: "千里江陵一日还。", style: TextStyle(color: Colors.green)
        ),
        TextSpan(
            text: "两岸猿声啼不住，", style: TextStyle(color: Colors.red)
        ),
        TextSpan(
          text: "轻舟已过万重山。", style: TextStyle(color: Colors.deepPurple)
        )
    ]
  )
),
```

### 设置字体



## RichText

[RichText](https://api.flutter.dev/flutter/widgets/RichText-class.html) 用于设置富文本样式文本。

`RichText` 显示使用多种不同样式的文本。要显示的文本使用 `TextSpan` 对象的树来描述，每个对象都有一个用于子树的关联样式。根据布局限制，文本可以跨多行显示，也可以全部显示在同一行上。

显示在 `RichText` 中的文本必须显式设置样式。当选择使用哪种样式时，考虑使用`DefaultTextStyle.of` 当前的 `BuildContext` 来提供默认值。

```Dart
RichText(
    text: const TextSpan(
        text: "￥",
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: <TextSpan>[
          TextSpan(text: '100', style: TextStyle(fontSize:28, fontWeight: FontWeight.bold)),
          TextSpan(text: '.00', style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)),
        ]
    ),
)
```

## Image

[Image class](https://api.flutter.dev/flutter/widgets/Image-class.html)为可以指定图像的各种方式提供了几个构造函数：

* [new Image](https://api.flutter.dev/flutter/widgets/Image/Image.html)，用于从`ImageProvider`获取图像。

* [new Image.asset](https://api.flutter.dev/flutter/widgets/Image/Image.asset.html)，用于使用`key`从[AssetBundle](https://api.flutter.dev/flutter/services/AssetBundle-class.html)获取图像。

* [new Image.network](https://api.flutter.dev/flutter/widgets/Image/Image.network.html)，用于从URL获取图像。

* [new Image.file](https://api.flutter.dev/flutter/widgets/Image/Image.file.html)，用于从文件获取图像。

* [new Image.memory](https://api.flutter.dev/flutter/widgets/Image/Image.memory.html)，用于从 `Uint8List` 获得图像。

`Image` 支持以下图像格式：JPEG, PNG, GIF, Animated GIF, WebP, Animated WebP, BMP, 和 WBMP。底层平台可能支持其他格式。`Flutter`将尝试调用平台API来解码无法识别的格式，如果平台`API`支持解码图像，`Flutter`将能够呈现图像。

要自动执行 `pixel-density-aware` 的资源解析，请使用 [AssetImage](https://api.flutter.dev/flutter/painting/AssetImage-class.html) 指定图像，并确保小部件树中的 `Image` 小部件上方存在 `MaterialApp`、 `WidgetsApp` 或 `MediaQuery`。


### Image.asset

获取本地图片，需要在根目录下的 [pubspec.yaml](https://dart.dev/tools/pub/pubspec) 文件配置图片资源的路径，该路径是相对于 `pubspec.yaml` 文件的。

如下修改 `pubspec.yaml` 文件项目从 `assets/images/` 目录下加载图片，并且把图片资源拖放到该目录下存放：
```
flutter:
  assets:
    - assets/images/
```

> 注意，这个地方书写格式不正确会导致图片无法加载，必须要保证 `assets:` 是 `flutter` 层级下面的，所以书写 `assets:` 时前面必须保证有 2 个空格。具体可参考：[Flutter and the pubspec file](https://docs.flutter.dev/development/tools/pubspec)
> 
> 当然有时候需要 `flutter clean` 清理缓存

显示图片：

```Dart
const Image(image: 
    AssetImage('assets/images/ke_nan_two.png'), 
    width: 350,
),
Container(
  color: Colors.red.withOpacity(0.3),
  child: Image.asset('assets/images/ke_nan.png', 
    width: 200, 
    height: 250, 
    fit: BoxFit.contain, 
    alignment: Alignment.topLeft,
    filterQuality: FilterQuality.low, 
  ),
),
```

* `fit` 参数

`fill`：完全填充，宽高比可能会变。
`contain`：等比拉伸，直到一边填充满。
`cover`：等比拉伸，直到2边都填充满，此时一边可能超出范围。
`fitWidth`：等比拉伸，宽填充满。
`fitHeight`：等比拉伸，高填充满。
`none`：当组件比图片小时，不拉伸，超出范围截取。
`scaleDown`：当组件比图片小时，图片等比缩小，效果和 `contain` 一样。

* `BoxFit.none` 的裁减和 `alignment` 参数相关，默认居中，


另外也可以根据屏幕像素比来自动加载对应的图片，需要在 `pubspec.yaml` 文件中配置如下：

```
flutter:
  assets:
    - images/cat.png 
    - images/2x/cat.png
    - images/3.5x/cat.png
```

可以把 `images/cat.png` 图片文件可以从磁盘中省略，但是不能把他从 `pubspec.yaml` 文件清单中删除，在设备像素比为 1.0 的设备上，将自动使用 `images/2x/cat.png` 替代。

* 使用 `scale` 参数时，必须提供准确的路径，不能根据屏幕像素比来自动加载对应的图片。

```
Image.asset('assets/images/2x/ke_nan_two.png', scale: 2, width: 200, height: 250)
```

* `filterQuality` 参数表示绘制图像的质量，从高到低为：high->medium->low->none，默认是 `low`。

### Image.network

[Image.network](https://docs.flutter.dev/cookbook/images/network-image) 只是简单的从网络上加载图片，支持Gif，它不处理更高级的功能，如：加载后淡入图像、在下载图像后将图像缓存到设备等。

```
Image.network(
  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
  width: 200,
  fit: BoxFit.fitWidth,
)
```

## FadeInImage

[FadeInImage](https://docs.flutter.dev/cookbook/images/fading-in-images) 适用于任何类型的图像：内存中、本地资产或来自互联网的图片，它的主要作用是在加载图片时首先显示一个占位符效果。

如下使用本地资源作为占位符：
```
FadeInImage.assetNetwork(placeholder: 'assets/images/ke_nan.png',
  image: 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
  width: 200,
)
```


## Icon

[Icon class](https://api.flutter.dev/flutter/widgets/Icon-class.html) 一个表示图形图标的小组件，它由 [IconData](https://api.flutter.dev/flutter/widgets/IconData-class.html) 中描述的字体绘制而成。`Icon` 只能呈现方形图标。

如下使用 [Icons class](https://api.flutter.dev/flutter/material/Icons-class.html) 中预定义的 [IconData](https://api.flutter.dev/flutter/widgets/IconData-class.html)

```
const Icon(
  Icons.beach_access,
  color: Colors.pink,   // 绘制图标的颜色
  size: 60,   // 图标的大小，以逻辑像素为单位
  semanticLabel: "爱心",    // 语意标签，不知道有什么用
),
const Icon(
  IconData(0xe0d6, fontFamily: 'MaterialIcons', matchTextDirection: true),
  color: Colors.pink,
  size: 50,
  semanticLabel: "小爱心",
  textDirection: TextDirection.rtl,   // 设置图标显示的方向，只在 IconData 的 matchTextDirection 属性为true 时，才生效
),
```

`Icons class`不具有交互功能，如需要可以使用 [IconButton class](https://api.flutter.dev/flutter/material/IconButton-class.html)。

