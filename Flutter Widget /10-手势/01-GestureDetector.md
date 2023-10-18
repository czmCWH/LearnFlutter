## GestureDetector

[GestureDetector](https://api.flutter-io.cn/flutter/widgets/GestureDetector-class.html) 检测手势的组件。尝试识别与其非空回调对应的手势。

* 如果`GestureDetector`有子项，它遵从那个子项的尺寸行为。如果它没有子项，它就会变得适合父级。

* 默认情况下，带有不可见子项的 `GestureDetector` 会忽略触摸；这种行为可以用 `behavior` 来控制。

* `GestureDetector` 响应触摸事件的顺序：
    按下时：`onTapDown-> onTapUp-> onTap`
    抬起时：`onTapDown-> onTapCancel`

```dart
import 'package:flutter/material.dart';

class MyGestureWidget extends StatefulWidget {
  const MyGestureWidget({Key? key}): super(key: key);

  @override
  State<MyGestureWidget> createState() {
    return _MyGestureWidgetState();
  }
}

class _MyGestureWidgetState extends State<MyGestureWidget> {
  Color _bgColor = Colors.red;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("手势的使用"),),
        body: Container(
          color: _bgColor,
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              color: Colors.purple,   // 注意如果设置颜色为 white, 则手势无法响应
              child: GestureDetector(
                onTapDown: (TapDownDetails tapDownDetails) {
                  debugPrint("按下时回调 ${tapDownDetails.localPosition}");
                },
                onTapUp: (TapUpDetails tapUpDetails) {
                  debugPrint("抬起时回调。");
                },
                onTap: () {
                  debugPrint("点击事件回调");
                  setState(() {
                    _bgColor == Colors.orange ? _bgColor = Colors.red : _bgColor = Colors.orange;
                  });
                },
                onTapCancel: () {
                  debugPrint("点击取消事件回调");
                },
                child: const Center(
                  child: Text('切换颜色', style: TextStyle(fontSize: 15, color: Colors.white),),
                ),
              ),
            ),
          )
        ),
      ),
    );
  }
}
```


有关调试的设置如下：

```dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintPointersEnabled = true;     // 打开调试时，命中测试框有多大
  debugPaintSizeEnabled = true;     // 打开调试时，显示每个组件的大小
  runApp(MyGestureWidget());
}

```

## 参考博客

[点击、拖动和其他手势](https://flutter.cn/docs/development/ui/advanced/gestures)