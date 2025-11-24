/* 
  <https://dart.cn/language/class-modifiers#interface> 
 
 1、interface 接口类
  Dart 3.0 新增 interface 修饰符用于定义接口类。接口类特点如下：
   - 接口类只能被 implements 实现，不能被 extends 继承；
   - 接口类中可以定义构造方法，可以被实例化；
   - 接口类中的所有属性、方法都必须被重写；

  interface class 在自身库内可以被 extend(继承)，自身定义库之外只能实现。这可以保证：
     当类的一个实例方法调用该类的另一实例方法时，它将始终调用来自同一库的已知方法实现。
     其他库不能重写接口类自己的方法以后可能以意外方式调用的方法。这减少了脆弱的 base class 的问题。

 2、Implicit interfaces 隐式接口
  <https://dart.cn/language/classes#implicit-interfaces>
  每个类都隐式地定义了一个 interface(接口)，该 interface 包含该类及其实现的任何接口的所有实例成员。
  如果你想创建一个支持 类B的API 而不继承 类B 的实现的 类A，那么 类A 应该实现 类B 的接口。
  
  类通过在 implements子句 中声明一个或多个接口，然后提供接口所需的 API 来实现这些接口。语法如下:
    class 类A implements [类B名称], [接口C]... {
         //...
    }
  
 3、interface abstract class 抽象接口类
  interface 和 abstract 修饰符可以组合使用，定义抽象接口类。

 */

void main(List<String> args) {

  // 接口类可以被实例化
  Shape sp = Shape(area: 65.4);
  
  // Dart 多态实现方式3 --- 接口
  Shape shape = Circle(isResizable: true);
  shape.render(); // Drawing a circle...

  Resizable resizable = shape as Resizable;
  resizable.resize(2);
}

// ----------------------------- 1、接口类
// 纯接口：只定义行为契约
interface class Shape {
  double? area;
  void render() {
    print('--- 抽象接口类 render');
  }

  // 定义构造函数
  Shape({this.area});
}

interface class Resizable {
  bool isResizable = false;

  void resize(double factor) {
    print('--- 抽象接口类 resize = $factor');
  }
}

class Circle implements Shape, Resizable {
  @override
  double? area;

  @override
  bool isResizable;

  Circle({required this.isResizable});
  
  @override
  void render() {
    // this.render(); // ⚠️，如果调用 render 会死循环
    print('--- 子类 render');
  }
  
  @override
  void resize(double factor) {
    print('--- 子类 resize');
  }
}

// ----------------------------- 2、隐式接口
class Person {
  final String name;
  Person(this.name);

  String inviteSome(String one) => '$name invite $one';
}

class Man implements Person {
  @override
  String get name => '帅气 boy';

  @override
  String inviteSome(String one) => '$name invite $one to go fishing';
}
