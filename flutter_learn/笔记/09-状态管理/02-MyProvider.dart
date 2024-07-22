/*
<https://docs.flutter.cn/data-and-backend/state-mgmt/intro>
<https://book.flutterchina.club/chapter2/state_manage.html#_2-3-1-%E7%AE%80%E4%BB%8B>
<https://github.com/rrousselGit/provider/blob/master/resources/translations/zh-CN/README.md>
<https://juejin.cn/post/7306447634204999695#heading-1>

--- 状态管理

👉 1、状态
状态是指 当任何时候你需要重建你的用户界面时你所需要的数据。

如果状态是组件私有的，则应该由组件自己管理；如果状态要跨组件共享，则该状态应该由各个组件共同的父元素来管理。

1.2、跨组件共享状态的管理方式
* 全局事件总线 EventBus
* provider package：用来管理简单的全局应用状态。
* 其它插件：<https://book.flutterchina.club/chapter7/provider.html#_7-3-4-%E5%85%B6%E4%BB%96%E7%8A%B6%E6%80%81%E7%AE%A1%E7%90%86%E5%8C%85>

--- provider 插件

provider 插件 用于为其子孙节点提供数据和服务。
<https://pub-web.flutter-io.cn/packages/provider>
<https://pub-web.flutter-io.cn/documentation/provider/latest/provider/provider-library.html>
添加 provider：
  flutter pub add provider 
导入 provider：
  import 'package:provider/provider.dart'; 

* provider 的三个重要概念：
  ChangeNotifier
  ChangeNotifierProvider
  Consumer

👉 1、ChangeNotifier

* ChangeNotifier 是 Flutter SDK 中的一个简单的类。可以订阅它的状态变化，它可以向监听器发送通知。

* 在 provider 中，ChangeNotifier 是一种能够封装 App 状态的方法。对于特别简单的程序，你可以通过一个 ChangeNotifier 来满足全部需求。

👉 2、Provider

* ChangeNotifierProvider widget 可以向其子孙节点暴露一个 ChangeNotifier 实例。它属于 provider package。
* ChangeNotifierProvider 放置在需要访问它的 widget 之上。 

👉 3、Consumer

* Consumer widget 唯一必须的参数就是 builder。当 ChangeNotifier 发生变化的时候会调用 builder 这个函数。
* 最好能把 Consumer 放在 widget 树尽量低的位置上。避免 UI 上任何一点小变化就全盘重新构建 widget 。

3.1、Provider.of
Provider.of 静态方法，可以用来访问模型中的数据，但不改变UI。

 */


import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

class Person{
  String name = "Provider";

  void changeName() {
    name = "hello";
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*
     1、Provider
      Provider：最基础的 provider 组成，接收一个任意值并暴露它。但是当该值更改的时候，并不会更新UI。 
      应用场景：
            用于避免为一些琐碎的事情创建 StatefulWidget。
     */
    return Provider<Person>(
      create: (context) => Person(),  // create 是延迟调用的，当第一次读取它的值时被调用，而不是在首次将 Provider 插入到 widget 树中时调用。
      child: const MaterialApp(
        home: MyProvider(),
        debugShowCheckedModeBanner: false,   
      ),
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
        title: const Text('Provider 的使用'),
      ),
      body: Center(
        child: Consumer<Person>(   // Consumer 在程序任何地方都可以拿到person对象，读取数据
          builder: (context, value, child) {
            return Column(
              children: [
                Text('接收的值: ${value.name}'),
                ElevatedButton(
                  onPressed: () {
                    value.changeName();
                  }, 
                  child: const Text('改变值'),
                ),
              ],
            );
          },
        ),
      )
    );
  }
}

