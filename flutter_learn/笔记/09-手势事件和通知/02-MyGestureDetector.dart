/*
点击、拖动和其他手势，<https://docs.flutter.cn/ui/interactivity/gestures>
<https://api.flutter-io.cn/flutter/widgets/GestureDetector-class.html>

👉 1、GestureDetector Widget
GestureDetector 是一个检测手势的 Widget，比如：触摸、点击、滑动等。

特点：
  - 如果其 child 接收一个 Widget，那么它从该 Widget 上获取发生的触摸手势。
  - 如果其 child 没有值，则它会继承父元素的大小，来获取父元素上发生的触摸手势。
  - 默认情况下，带有不可见子项的 GestureDetector 会忽略触摸，可以用其 behavior 属性来控制。
  - 当2个 GestureDetector 嵌套时，内部的 GestureDetector 被点击时，只会调用内部 GestureDetector 的 onTap 被调用，而父级的 onTap 不会被调用。

调试：
  在 main 函数中，首先 import 'package:flutter/rendering.dart'; 设置 debugPaintPointersEnabled = true; 即可查看 GestureDetector 的触摸框大小。


👉 2、其它可被点击组件
* 专用按钮组件：
  - ElevatedButton、TextButton、CupertinoButton、OutlinedButton、FloatingActionButton

* 点按涟漪效果 (Material Design) 组件：
 - InkWell

* 其它交互组件
  - IconButton、Switch、Checkbox

*/

import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyGestureDetector(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyGestureDetector extends StatefulWidget {
  // 定义常量构造函数
  const MyGestureDetector({ Key? key }) : super(key: key);

  // 存储可变状态
  @override
  State<MyGestureDetector> createState() {
    return _MyGestureDetector();
  }
}

class _MyGestureDetector extends State<MyGestureDetector> {

  String _operation = "手势事件名"; 

  // 图片的宽度，进行缩放
  double _imgW = 200.0; 

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: Center(
      child: Column(
        children: [
          // 1、检测点击手势的方法
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 200.0,
              height: 100.0,
              child: Text(
                _operation,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onTap: () => updateText("点击"), 
            onDoubleTap: () => updateText("双击"),
            onLongPress: () => updateText("长按"), 
          ),
          
          // 2、监听缩放手势
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0), 
            child: GestureDetector(
              child: Image.asset("images/PurpleFlower.jpg", width: _imgW),
              onScaleUpdate: (ScaleUpdateDetails details) {
                setState(() {
                  //缩放倍数在0.8到10倍之间
                  _imgW=200*details.scale.clamp(.8, 10.0);
                });
              },
            ),
          ),
        
          // 3、GestureDetector没有 child 时，点击范围和父组件相同
          Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.all(10.0),
            color: Colors.orange,
            child: GestureDetector(
              onTap: () => {
                debugPrint('---- GestureDetector没有 child 时，点击范围和父组件相同')
              },
            )
          ),

        ],
      )
    ),
    );
  }

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }
}
