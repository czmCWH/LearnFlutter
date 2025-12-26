# 一、Flutter 与其它跨平台对比
https://juejin.cn/post/7329144189001515048?searchId=2024051110482073DE2668163869A23155

# 二、Widget
<https://docs.flutter.cn/ui/widgets>
<https://docs.flutter.cn/get-started/fundamentals/widgets>

Flutter widgets 是使用现代框架构建的，它的灵感来自于 React，其中心思想是用 widgets 构建 UI。Flutter 中万物皆 Widget。

Widget 描述了在当前的配置和 state(状态) 下视图所应该呈现的样子。简单来说，widget 是声明和构建 UI 的方法。 

当 widget 的状态发生变化时，widget 会重新构建其描述，框架会对比前后描述变化的不同，以确定底层渲染树从一种状态过渡到另一种状态所需的最小更改。(类似于`React/Vue`中虚拟`DOM`的`diff`算法）。


# 三、Material 库

* Flutter SDK 中附带了两套设计系统，它们都提供了遵循各自 Design 原则的 widget。
  - Cupertino，符合苹果公司针对 iOS 和 macOS 的人机界面指南风格。
  - Material，是 Google 公司推行的一套设计风格，为 Android、Web、iOS、HarmonyOS 多个平台提供统一的交互和视觉体验。

* 从 Flutter 3.16 版本开始， Material 3 是 Flutter 的默认主题。

* 基础(标准) Widget，一系列常用的功能，如输入、布局和文本。

使用 Material Design 的 App 称为 Material App，它从 `MaterialApp` widget 开始，许多 Material Design widgets 需要位于 MaterialApp 内部才能正确显示，标准 widget 库 中的 widget 也能在 Material 中使用。

使用 `Materials library` 时，需要在 `pubspec.yaml` 文件中配置如下：
```yml
flutter:
  uses-material-design: true
```

基础(标准) Widget，<https://docs.flutter.cn/ui/widgets>、<https://api.flutter-io.cn/flutter/widgets>
Material 库，<https://api.flutter-io.cn/flutter/material/>

## 构建一个 Material 应用

> MaterialApp，便捷组件， 包裹整个应用形成统一的 Material Design 风格。
> Scaffold，骨架组件，实现了基本的 Material Design 视觉布局结构，提供标准、灵活配置的页面骨架。

<https://docs.flutter.cn/ui/layout>


```dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'MainApp.dart';

void main() {

  // debug 模式时，显示每个组件的大小，查看可视化布局
  debugPaintSizeEnabled = false;
  // 调试显示 GestureDetector 触摸框的大小。需要 import 'package:flutter/rendering.dart';
  debugPaintPointersEnabled = false;
  // 在 debug 模式下，每次调用手势识别器回调时都会记录一条消息。需要 import 'package:flutter/gestures.dart'; 
  debugPrintRecognizerCallbacksTrace = true;

  // runApp()函数接受给定的 Widget，并将其作为Widget树的根。
  runApp(const MainApp());
}
 
```

```dart
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {

  // Widget 构造器
  const MainApp({super.key});

  // build() 方法中实例化和返回一个 widget 会让它显示出来
  @override
  Widget build(BuildContext context) {
    
    const String appTitle = 'Material 风格的 App';

    // 一个 Material App 从 MaterialApp 小部件开始
    return MaterialApp(
      // title：窗口标题，显示在浏览器上小字。
      title: appTitle,
      
      // theme：设置整个应用的主题，scaffoldBackgroundColor 主骨架的背景色。
      theme: ThemeData(scaffoldBackgroundColor: Colors.blue),

      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   

      // home：窗口展示的主体内容。
      home: Scaffold(

        // appBar，页面顶部导航栏
        appBar: AppBar(title: const Text(appTitle)),
        
        // backgroundColor，整个页面背景颜色
        backgroundColor: Colors.white,
        
        // body，整个页面的内容区域
        body: Container(
          child: const Center(
            child: Text('Hello World!'),
          ),
        ),

        // bottomNavigationBar，底部导航栏
        bottomNavigationBar: Container(
          height: 80,
          child: const Center(
            child: Text('底部区域'),
          ),
        ),
      ),
      
    );
  }
}
```

