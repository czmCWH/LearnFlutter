/*
<https://pub-web.flutter-io.cn/documentation/provider/latest/provider/StreamProvider-class.html>

---- 监听 Stream 流

👉 1、StreamProvider
StreamProvider 监听 Stream 并将其结果暴露给子孙节点。

传递可能发出错误的流而不提供 catchError 方法将被视为错误。
默认情况下，StreamProvider 认为监听的 Stream 使用不可变数据。因此，如果前一个值和新值是 ==，它不会重建依赖项。要更改此行为，请传递自定义 updateShouldNotify。

 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

class CounterModel{

  CounterModel({this.name});

  String? name = "Jimi";

  void changeName() {
    name = "hello";
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return StreamProvider(
      create: (context) {
        return Stream<CounterModel>.periodic(const Duration(milliseconds: 1000),
          (value) => CounterModel(name: "$value")
        ).take(100);
      },
      initialData: CounterModel(name: '默认值'),
      child:  const MaterialApp(
        home: MyStreamProvider(),
        debugShowCheckedModeBanner: false,   
      ),
    );
  }
}

class MyStreamProvider extends StatelessWidget {
  
  const MyStreamProvider({super.key, this.tipStr});

  final String? tipStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamProvider'),
      ),
      body: Center(
        child: Consumer<CounterModel>(
          builder: (context, value, child) {
            return Column(
              children: [
                Text('${value.name}'),
                ElevatedButton(
                  onPressed: (){
                    value.name = '哈哈';
                  },
                  child: const Text("改变值"),
                ),

              ],
            );
          },
        )
      ),
    );
  }
}
