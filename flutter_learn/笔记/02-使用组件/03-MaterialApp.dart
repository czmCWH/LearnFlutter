/*
👉 1、MaterialApp Widget

<https://api.flutter-io.cn/flutter/material/MaterialApp-class.html>

MaterialApp 是一个方便的 Widget，它包装了许多 Material 设计 App 通常需要的小部件。
它在 WidgetsApp 的基础上添加了特定于 material-design 的功能，如 AnimatedTheme 和 GridPaper。

MaterialApp将其 WidgetsApp.textStyle 配置为丑陋的红/黄文本样式，旨在警告开发者他们的应用程序尚未定义默认文本样式。

通常，App 的 Scaffold 会构建一个 Material Widget，其默认 Material.textStyle 定义整个 Scaffold 的文本样式。

👉 2、MaterialApp 的导航器
MaterialApp 将顶级 Navigator 配置为按以下顺序搜索路由：
> 1、对于 / 路由，如果 home 属性非空，则使用该属性。
> 2、否则，如果 routes table(路由表) 有路由条目，则使用路由表。
> 3、否则，将调用 onGenerateRoute（如果提供）。它应该为 未由 home 和 routes 处理的任何有效路由 返回一个非null值。
> 4、最后，如果所有其他方法都失败，则调用 onUnknownRoute。

* 如果创建了 Navigator，这些选项中至少有一个必须处理 / route，因为它是在启动时指定无效 initialRoute 时使用的。
* MaterialApp 还配置顶级 Navigator（如果有的话）的观察者来执行 Hero 动画。
* 如果 home、routes、onGenerateRoute 和 onUnknownRoute 都为 null，并且 builder 不为 null，则不会创建 Navigator。

MaterialApp 会自动创建一个 DefaultSelectionStyle。如果 ThemeData.textSelectionTheme 中的颜色不为 null，则使用该颜色；
否则，MaterialApp 将 DefaultSelectionStyle.selectionColor 设置为 ColorScheme.prprimary，不透明度为0.4，并将 DefaultSelection Style.cursorColor 设置为 ColorScheme.primal。 

 */

import 'package:flutter/material.dart';
import '04-MyScaffold.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyScaffold(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}
