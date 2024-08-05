/*
<https://api.flutter-io.cn/flutter/gestures/gestures-library.html>
<https://api.flutter-io.cn/flutter/gestures/GestureRecognizer-class.html>


---- 手势识别器

👉 1、GestureRecognizer

GestureRecognizer 所有手势识别器继承的基类。它是一个抽象类。
GestureRecognizer 的作用就是通过 Listener 来将原始指针事件转换为语义手势。

* debugPrintRecognizerCallbacksTrace = true; 表示在 debug 模式下，每次调用手势识别器回调时都会记录一条消息。

GestureRecognizer 的实现类非常多。

 */

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyGestureRecognizer(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyGestureRecognizer extends StatefulWidget {
  // 定义常量构造函数
  const MyGestureRecognizer({ Key? key }) : super(key: key);

  // 存储可变状态
  @override
  State<MyGestureRecognizer> createState() {
    return _MyGestureRecognizer();
  }
}

class _MyGestureRecognizer extends State<MyGestureRecognizer> {
  
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false; //变色开关

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: "你好世界"),
                  TextSpan(
                    text: "点我变色",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: _toggle ? Colors.blue : Colors.red,
                    ),
                    recognizer: _tapGestureRecognizer
                      ..onTap = () {
                        setState(() {
                          _toggle = !_toggle;
                        });
                      },
                  ),
                  const TextSpan(text: "你好世界"),
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}
