/*
 * 1、Implicit interfaces 隐式接口
 * 
 * 每个类都隐式地定义了一个接口，其中包含该类及其实现的任何接口的所有实例成员。
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