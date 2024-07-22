/*
<https://api.flutter-io.cn/flutter/foundation/ChangeNotifier-class.html>
<https://api.flutter-io.cn/flutter/foundation/Listenable-class.html>

--- 观察者模式

👉 1、Listenable
Listenable 是一个抽象类，它是一个维护 listeners(侦听器) 列表的对象。
listeners(侦听器) 通常用于通知客户端对象已被更新。

Listenable 的实现类有：
  Animation、ChangeNotifier、CustomClipper、CustomPainter
  OverlayEntry、PipelineManifold、RouterDelegate、ValueListenable


👉 2、ChangeNotifier

ChangeNotifier 是一个 mixin。它使用 VoidCallback 提供更改通知API。


 */

import 'package:flutter/material.dart';
import 'dart:math';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyChangeNotifier(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

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

class MyChangeNotifier extends StatefulWidget {

  const MyChangeNotifier({ Key? key }) : super(key: key);

  @override
  State<MyChangeNotifier> createState() {
    return _MyChangeNotifier();
  }
}

class _MyChangeNotifier extends State<MyChangeNotifier> {

   final CounterModel _counter = CounterModel();  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('观察者模式'),
      ),
      body: Center(
        child: Column(
          children: [
            MyCounter(notifierModel: _counter),
            ElevatedButton(
              onPressed: () {
                _counter.add();
              },
              child: const Text('增加'),
            ),
            MyMinus(notifierModel: _counter),
          ],
        ),
      )
    );
  }

}


class MyCounter extends StatelessWidget {
  const MyCounter({super.key, required this.notifierModel});

  final CounterModel notifierModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const Text('Current counter value:'),
          ListenableBuilder(    // ListenableBuilder 用于在 Listenable 更改时构建 Widget 子树。
            listenable: notifierModel,
            builder: (BuildContext context, Widget? child) {
              return Text('${notifierModel.count}');
            },
          ),
        ],
      ),
    );
  }
}

class MyMinus extends StatelessWidget {
  const MyMinus({super.key, required this.notifierModel});

 final CounterModel notifierModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Random random = Random();
          notifierModel.minus(random.nextInt(10));
        }, 
        child: const Text('减少'),
      ),
    );
  }
}

