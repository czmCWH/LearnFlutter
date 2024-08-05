/*
<https://pub-web.flutter-io.cn/packages/provider>
<https://pub-web.flutter-io.cn/documentation/provider/latest/provider/ChangeNotifierProvider-class.html>

---- 监听 ListenableProvider

👉 2、ListenableProvider

ListenableProvider 是 ChangeNotifierProvider 父类，它类似于 ChangeNotifierProvider，但适用于任何 Listenable。

Listenable 是 Flutter 库中的类。

 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

class CounterModel with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void add() {
    _count += 1;
    notifyListeners();
  }

  void minus(int num) {
    _count -= num;
    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child:  const MaterialApp(
        home: MyChangeNotifierProvider(),
        debugShowCheckedModeBanner: false,   
      ),
    );
  }
}

class MyChangeNotifierProvider extends StatefulWidget {

  const MyChangeNotifierProvider({ Key? key }) : super(key: key);

  @override
  State<MyChangeNotifierProvider> createState() {
    return _MyChangeNotifierProvider();
  }
}

class _MyChangeNotifierProvider extends State<MyChangeNotifierProvider> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeNotifierProvider'),
      ),
      body: Center(
        child: Consumer<CounterModel>(    // Consumer 共享数据
          builder: (context, value, child) {
            return Column(
              children: [
                Text('数量为：${value._count}'),
                ElevatedButton(
                  onPressed: () {
                    value.add();
                  }, 
                  child: const Text('增加'),
                ),
                ElevatedButton(
                  onPressed: () {
                    value.minus(2);
                  }, 
                  child: const Text('减少'),
                ),
              ],
            );
          },
        ),
      )
    );
  }

}
