/*

<https://pub-web.flutter-io.cn/documentation/provider/latest/provider/ProxyProvider-class.html>

---- 

👉 1、ProxyProvider
ProxyProvider 是基于其他 providers 建立值的 provider。
暴露的值通过 create 或 update 构建，然后传递给 InheritedProvider。

ProxyProvider 有不同的变体，例如 ProxyProvider2~6。

* 注意：如果你想将可能被外界修改的变量传入给对象，请使用 ProxyProvider：


 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

class MyModel { 
  
  String someValue = 'Hello';

  MyModel({required this.someValue});

  void doSomething(String value) {
    someValue = value;
    // notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyProxyProvider(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyProxyProvider extends StatefulWidget {

  const MyProxyProvider({ Key? key }) : super(key: key);

  @override
  State<MyProxyProvider> createState() {
    return _MyProxyProvider();
  }
}

class _MyProxyProvider extends State<MyProxyProvider> {
  
  // 如果你想将可能被外界修改的变量传入给对象，请使用 ProxyProvider：
  String someText = '外部值';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: ProxyProvider0(
        update: (context, obj) {
          return MyModel(someValue: someText);    // 使用外部值
        },
        child: Consumer<MyModel>(
          builder: (context, value, child) {
            return Column(
              children: [
                Text(value.someValue),
                ElevatedButton(
                  onPressed: () {
                    // 修改外部值会被监听到
                    setState(() {
                      someText = '修改为: 哈哈哈';  
                    });
                  }, 
                  child: const Text('修改值'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}
