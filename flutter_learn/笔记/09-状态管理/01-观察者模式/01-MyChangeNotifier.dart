/*
<https://api.flutter-io.cn/flutter/foundation/ChangeNotifier-class.html>
<https://api.flutter-io.cn/flutter/foundation/Listenable-class.html>
<https://docs.flutter.cn/community/tutorials/observer-pattern-in-flutter-n-dart#changenotifier>

--- 使用观察者模式进行状态管理

👉 1、Listenable 可观察对象(or 被观察者)

Listenable 是一个抽象类，它是一个维护 listeners(观察者、侦听器) 列表的对象。
listeners(观察者、侦听器) 通常用于 通知客户端对象已被更新 。

Listenable 的实现类有：
  Animation、ChangeNotifier、CustomClipper、CustomPainter
  OverlayEntry、PipelineManifold、RouterDelegate、ValueListenable

👉 2、订阅者 Widget

* ListenableBuilder：是一个通用 Widget，用于在 Listable(任何子类型) 更改时构建小部件子树。
* AnimatedBuilder：它是 ListenableBuilder 的子类，常用于监听 Animation。
* ValueListenableBuilder：
      专门用于 ValueNotifier，并在其构建器回调中报告新值。
      ValueNotifier 是一个抽象类，其实现类有：Animation、RouteInformationProvider、SelectionHandler、ValueNotifier

👉 4、NavigatorObserver 路由观察者
见 02-MyNavigatorObserver.dart

👉 3、provider package

Flutter 应用中最传统的状态管理方案是使用有状态 widget 的 setState 的方法，这种方式暴露出来的问题是，大型应用中的 widget 树会非常复杂，
每当状态更新调用 setState 时，则会牵一发而动全身，重建所有子树，使性能大打折扣。

那么，当将 ChangeNotifier 观察者模式应用在状态管理方案中时，便能解决这个问题。
设想让每一个最小组件充当观察者，观察应用的状态，每当状态改变时即驱动该局部小组件更新，是不是就能达到这种目的。
我们常用 provider package 就应用了这个原理。

provider 内部提供了一个 ChangeNotifierProvider widget，可以向其子组件暴露一个 ChangeNotifier 实例 (被观察者) 。

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