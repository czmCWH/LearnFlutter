import 'package:flutter/foundation.dart';

/*
  混入 ChangeNotifier 来定义 状态模型 CounterModel，使它具备简单的 观察者模式。
 */
class CounterModel with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // 通知监听者重建
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}