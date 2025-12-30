/*

如果您需要执行一些无法在初始化列表中表示的逻辑，请使用该逻辑创建一个工厂构造函数(或静态方法)，然后将计算值传递给普通构造函数。
构造函数：https://mp.weixin.qq.com/s/dL31ZBu7DYR2mdSqpjUIvQ 

https://docs.flutter.cn/community/tutorials/singleton-pattern-in-flutter-n-dart
 */

void main(List<String> args) {
  
  Singleton sg = Singleton.getInstance();

  var db1 = Database();
  
}


class Singleton {
  // 私有静态属性实例
  static Singleton? _instance;

  // 私有的命名构造函数
  Singleton._internal();

  // 该实例只能通过静态方法
  static Singleton getInstance() {
    _instance ??= Singleton._internal();
    return _instance!;
  }
}

// 通过工厂构造函数实现单例
class Database {
  static final Database _instance = Database._internal();

  // 私有命名构造函数
  Database._internal();

  // 工厂构造函数：始终返回同一个实例
  factory Database() {
    return _instance;
  }

  void query(String sql) {
    print('Executing: $sql');
  }
}
