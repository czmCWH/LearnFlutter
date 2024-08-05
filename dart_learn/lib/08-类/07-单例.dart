/*
单例模式：https://docs.flutter.cn/community/tutorials/singleton-pattern-in-flutter-n-dart

 */

class Singleton {
  // 私有静态属性实例
  static Singleton? _instance;

  // 私有的命名构造函数
  Singleton._internal();

  // 该实例只能通过静态方法
  static Singleton getInstance() {
    if (_instance == null) {
      _instance = Singleton._internal();
    }
    return _instance!;
  }

}