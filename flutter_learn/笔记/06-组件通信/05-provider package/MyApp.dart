import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CounterModel.dart';
import 'HomePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 👉 1、使用 ChangeNotifierProvider 向 Widget 树传递响应式模型
    return ChangeNotifierProvider<CounterModel>(
      create: (context) => CounterModel(),  // create 是延迟调用的，当第一次读取它的值时被调用，而不是在首次将 Provider 插入到 widget 树中时调用。
      child: const MaterialApp(
        title: 'Provider 的基本使用',
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );


    // 👉 MultiProvider 用于提供多个状态模型
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