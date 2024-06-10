/* https://dart.cn/language/class-modifiers#interface
 * 
 * 1、interface 接口类
 * 要定义接口，请使用 interface 修饰符。
 * 
 * interface class 在自身库内可以被 extend(继承)，自身定义库之外只能实现。这可以保证：
 *    当类的一个实例方法调用该类的另一实例方法时，它将始终调用来自同一库的已知方法实现。
 *    其他库不能重写接口类自己的方法以后可能以意外方式调用的方法。这减少了脆弱的 base class 的问题。
 * 
 * 
 */

interface class Vehicle {
  void moveForward(int meters) {
    print('我是 interface class 接口类中的方法');
  }
}

// interface class 可以被实例化
Vehicle myVehicle = Vehicle();

// interface class 自身库内可以被继承
class Car extends Vehicle {
  int passengers = 4;
  // ...
}

// Can be implemented.
class MockVehicle implements Vehicle {
  @override
  void moveForward(int meters) {
    // ...
  }
}



 /* https://dart.cn/language/classes#implicit-interfaces
 * 
 * 2、Implicit interfaces 隐式接口
 * 
 * 每个类都隐式地定义了一个接口，该接口包含该类及其实现的任何接口的所有实例成员。
 * 如果你想创建一个支持 类B的API 而不继承 类B 的实现的 类A，那么 类A 应该实现 类B 的接口。
 * 
 * 类通过在 implements子句 中声明一个或多个接口，然后提供接口所需的 API 来实现这些接口。语法如下:
 *   class 类A implements [类B名称], [接口C]... {
 *        //...
 *   }
 * 
 */


class Person {
  final String name;
  Person(this.name);

  String inviteSome(String one) => '$name invite $one';
}

class HandSomeMan implements Person {
  String get name => '帅气 boy';

  String inviteSome(String one) => '$name invite $one to go fishing';
}

void testImplicitInterface() {
  var man = HandSomeMan();
  var res = man.inviteSome('钓鱼老');
  print(res);
}