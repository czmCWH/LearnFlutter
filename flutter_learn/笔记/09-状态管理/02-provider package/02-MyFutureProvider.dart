/*
<https://pub-web.flutter-io.cn/documentation/provider/latest/provider/FutureProvider-class.html>

---- 监听 Future

👉 1、FutureProvider

FutureProvider 监听 Future 并将其结果暴露给子孙节点。

传递 Future 而不提供 catchError 方法将被认为是错误。

FutureProvider 先显示初始值，然后显示Future值，之后不会再次重建。

 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return FutureProvider<String?>(
      create: (context) {
        return Future.delayed(const Duration(seconds:2), () => "FutureProvider监听Future");
      },
      initialData: null,
      child: const MaterialApp(
        home: MyFutureProvider(),
        debugShowCheckedModeBanner: false,   
      ),
    );
  }
}

class MyFutureProvider extends StatelessWidget {
  
  const MyFutureProvider({super.key, this.tipStr});

  final String? tipStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureProvider'),
      ),
      body: Center(
        child: Consumer<String?>(
          builder: (context, value, child) {
            return Column(
              children: [
                Text(value ?? '值为 null'),
                ElevatedButton(
                onPressed: () {
                  value = '哈哈哈';
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
