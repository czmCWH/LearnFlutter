/* 
<https://api.flutter-io.cn/flutter/widgets/Notification-class.html>

---- 通知

👉 1、Notification
Notification 可以冒泡到 widget tree 的通知。

* 要监听 subtree 中的通知，请使用 NotificationListener。

* 要发送通知，可使用 Notification.dispatch。通知将传递给具有适当类型参数的任何 NotificationListener Widget，
这些参数是给定 BuildContext 的祖先。如果 BuildContext 为 null，则不会调度通知。


 */
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyNotification(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyNotification extends StatefulWidget {
  // 定义常量构造函数
  const MyNotification({ Key? key }) : super(key: key);

  // 存储可变状态
  @override
  State<MyNotification> createState() {
    return _MyNotification();
  }
}

class _MyNotification extends State<MyNotification> {
  
  // 每次调用 setState方法 都会重新运行此方法
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: NotificationListener(
        onNotification: (Notification notification) { 
          switch (notification.runtimeType){
            case ScrollStartNotification: debugPrint("开始滚动"); break;
            case ScrollUpdateNotification: debugPrint("正在滚动"); break;
            case ScrollEndNotification: debugPrint("滚动停止"); break;
            case OverscrollNotification: debugPrint("滚动到边界"); break;
          }
          // 当返回 false 则表示通知可以继续向上层节点分发。反之也就意味着通知被截断。
          return false;
        },
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(title: Text("$index"),);
          }
        ),
      ),
    );
  }
}
