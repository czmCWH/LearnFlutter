/*
<https://api.flutter-io.cn/flutter/widgets/Listener-class.html>
<https://api.flutter-io.cn/flutter/widgets/NotificationListener-class.html> 

---- 监听原始触摸事件

👉 1、Listener

Listener 是一个调用回调来响应常见 pointer events(指针事件) 的 Widget。

Listener 监听可以构造手势的事件，例如按下、移动、然后释放或取消 pointer(指针) 时。

Listener 不监听鼠标独有的事件，例如鼠标进入、退出或悬停在某个区域而不按任何按钮时。对于这些事件，请使用 MouseRegion。

与其监听原始指针事件，不如考虑使用 GestureDetector 监听更高级别的手势。

 */

import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyListener(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyListener extends StatefulWidget {

  const MyListener({ Key? key }) : super(key: key);

  @override
  State<MyListener> createState() {
    return _MyListener();
  }
}

class _MyListener extends State<MyListener> {

  int _downCounter = 0;
  int _upCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _incrementDown(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _downCounter++;
    });
  }

  void _incrementUp(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _upCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: Center(
        child: ConstrainedBox(
            constraints: BoxConstraints.tight(const Size(300, 500)),
            child: Listener(
            onPointerDown: _incrementDown,     // 手指按下回调
            onPointerMove: _updateLocation,    // 手指移动回调
            onPointerUp: _incrementUp,         // 手指抬起回调
            child: ColoredBox(
              color: Colors.lightBlueAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                      '点击本区域的次数：'),
                  Text(
                    '按下: $_downCounter \n抬起: $_upCounter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    '点击的坐标: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
