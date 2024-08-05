/*
<https://pub-web.flutter-io.cn/packages/provider>
<https://pub-web.flutter-io.cn/documentation/provider/latest/provider/provider-library.html>

--- 观察者模式 provider package

👉 1、安装 provider package

provider package 用于为其子孙节点提供数据和服务。
添加 provider：
  flutter pub add provider 
导入 provider：
  import 'package:provider/provider.dart'; 

> 通常将 provider 与 ChangeNotifier 结合使用，<https://docs.flutter.cn/data-and-backend/state-mgmt/simple#our-example>


👉 2、ChangeNotifier

* ChangeNotifier 是 Flutter SDK 中的一个简单的类，它用于向监听器发送通知。可以订阅它的状态变化。

* 在 provider 中，ChangeNotifier 是一种能够封装 App 状态的方法。对于特别简单的程序，你可以通过一个 ChangeNotifier 来满足全部需求。
  在相对复杂的应用中，由于会有多个模型，所以可能会有多个 ChangeNotifier。 

> ChangeNotifier 用于定义响应式模型，存储App状态。

👉 3、ChangeNotifierProvider widget 

* ChangeNotifierProvider 是 provider package 中定义的 Widget。用于向其子孙节点暴露一个 ChangeNotifier 实例。

> ChangeNotifierProvider 作用是把响应式模型 与 应用中的 widget 相关联。

👉 4、Consumer widget

* Consumer widget 是 provider package 中定义的 Widget。

创建 Consumer 唯一必须的参数就是 builder。当 ChangeNotifier 发生变化的时候会调用 builder 这个函数。
最好能把 Consumer 放在 widget 树尽量低的位置上。避免 UI 上任何一点小变化就全盘重新构建 widget 。

> Consumer 作用是在 App Widget 结构中监听 ChangeNotifier 从而来构建 Widget。

👉 5、Provider.of

Provider.of 静态方法用来访问 响应式模型(ChangeNotifier) 中的数据。

 */


import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'dart:math';

class Person extends ChangeNotifier {
  String name = "Provider";

  void changeName(String str) {
    name = str;
    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    // ChangeNotifierProvider 用于提供 ChangeNotifier 类型的状态
    return ChangeNotifierProvider<Person>(
      create: (context) => Person(),  // create 是延迟调用的，当第一次读取它的值时被调用，而不是在首次将 Provider 插入到 widget 树中时调用。
      child: const MaterialApp(
        home: MyProviderPage(),
        debugShowCheckedModeBanner: false,   
      ),
    );
    
    // MultiProvider 用于提供更多状态
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<Person>(create: (context) => Person()),
    //   ],
    //   child: const MaterialApp(
    //     home: MyProviderPage(),
    //     debugShowCheckedModeBanner: false,   
    //   ),
    // );
  }
}

class MyProviderPage extends StatefulWidget {

  const MyProviderPage({ Key? key }) : super(key: key);

  @override
  State<MyProviderPage> createState() {
    return _MyProviderPage();
  }
}

class _MyProviderPage extends State<MyProviderPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 的使用'),
      ),
      body: Center(
        child: Consumer<Person>(   // Consumer 在程序任何地方都可以拿到person对象，读取数据
          builder: (BuildContext context, Person value, Widget? child) {  // 当状态发生改变时，就会执行 builder
            return Column(
              children: [
                Text('接收的值: ${value.name}'),
                ElevatedButton(
                  onPressed: () {
                    Random random = Random();
                    String randomIntStr = '随机数: ${random.nextInt(100) + 1}'; 
                    debugPrint('--- $randomIntStr');
                    value.changeName(randomIntStr);
                  }, 
                  child: const Text('改变值'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String nameValue = Provider.of<Person>(context, listen: false).name;
                    debugPrint('--- nameValue = $nameValue');
                  }, 
                  child: const Text('访问响应式模型中的数据'),
                ),
              ],
            );
          },
        ),
      )
    );
  }
}

