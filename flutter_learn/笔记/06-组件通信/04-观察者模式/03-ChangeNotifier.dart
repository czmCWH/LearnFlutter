/*
 <https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html>

 1、ChangeNotifier
  一个可以被继承或混合的类，它使用 VoidCallback 提供变更通知 API。
  适用于复杂的状态管理和业务逻辑处理。
  
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
  void initState() {
    super.initState();
    // 订阅可观察着模型，订阅
    _counter.addListener(() {
      debugPrint('---更新了 count = ${_counter.count}');
    });
  }

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

/// 被观察者模型
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