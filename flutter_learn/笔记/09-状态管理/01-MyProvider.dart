/*
<https://docs.flutter.cn/data-and-backend/state-mgmt/intro>
<https://book.flutterchina.club/chapter2/state_manage.html#_2-3-1-%E7%AE%80%E4%BB%8B>
<https://juejin.cn/post/7306447634204999695#heading-1>

--- 状态管理

👉 1、状态
一个应用的状态就是当这个应用运行时存在于内存中的所有内容。应用中用到的资源，所有 Flutter 框架中有关用户界面、动画状态、纹理、字体以及其他等等的变量。

1.1、短时 (ephemeral) 状态
短时状态（有时也称 用户界面 (UI) 状态 或者 局部状态）被用于一个单独 widget 的本地状态，通常使用 State 和 setState() 来实现。

* 子级传递状态到父级，可以通过在父级定义一个回调函数，并把它提供给子级。
Dart 的函数都是 first class 对象，所以你可以以任意方式传递它们。

1.2、应用状态
在你的应用中的多个部分之间共享一个非短时的状态，并且在用户会话期间保留这个状态，我们称之为应用状态（有时也称共享状态）。

* provider package：用来管理简单的全局应用状态。



👉 2、provider 插件
<https://pub-web.flutter-io.cn/packages/provider>
添加 provider：
  flutter pub add provider 
导入 provider：
  import 'package:provider/provider.dart'; 

* provider 的三个重要概念：
  ChangeNotifier
  ChangeNotifierProvider
  Consumer

2.1、ChangeNotifier

* ChangeNotifier 是 Flutter SDK 中的一个简单的类。它用于向监听器发送通知。
* 在 provider 中，ChangeNotifier 是一种能够封装应用程序状态的方法。对于特别简单的程序，你可以通过一个 ChangeNotifier 来满足全部需求。
* 不是必须得把 ChangeNotifier 和 provider 结合起来用，不过它确实是一个特别简单的类。

2.2、ChangeNotifierProvider

* ChangeNotifierProvider widget 可以向其子孙节点暴露一个 ChangeNotifier 实例。它属于 provider package。
* ChangeNotifierProvider 放置在需要访问它的 widget 之上。 

2.3、Consumer

* Consumer widget 唯一必须的参数就是 builder。当 ChangeNotifier 发生变化的时候会调用 builder 这个函数。
* 最好能把 Consumer 放在 widget 树尽量低的位置上。避免 UI 上任何一点小变化就全盘重新构建 widget 。

2.4、Provider.of
Provider.of

 */


import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyProvider(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyProvider extends StatefulWidget {

  const MyProvider({ Key? key }) : super(key: key);

  @override
  State<MyProvider> createState() {
    return _MyProvider();
  }
}

class _MyProvider extends State<MyProvider> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('provider 插件'),
      ),
      body: const Center(
        child: Column(
          children: <Widget>[

          ],
        ),
      )
    );
  }
}
