/* https://dart.cn/language/class-modifiers#abstract
 * 1、Abstract classes 抽象类
 * 
 * 要定义一个不需要完整、具体实现其整个接口的类，请使用 abstract 修饰符。
 * 抽象类 不能从任何库中构造，无论是自己的库还是外部库。抽象类通常具有 Abstract methods(抽象方法)。
 * 
 * 抽象类不能实例化。 
 * 
 * 
 * https://dart.cn/language/methods#abstract-methods
 * 2、Abstract methods 抽象方法 
 * 
 * 实例、getter和setter方法可以是抽象的，只定义接口不进行实现，而是留给其他类去实现。
 * 抽象方法只能存在于 abstract classes(抽象类) 或  mixins(混入) 中。
 * 
 * 要使方法抽象化，请使用分号（;）代替方法主体。
 * 
 * 3、抽象类的 factory constructor
 * 抽象类常用于声明方法。如果您希望抽象类看起来可实例化，请定义一个`factory constructor`(工厂构造函数)。
 * 
 * 
 */

abstract class Doer {
  // 定义实例变量和方法
  String name = '';

  void doSomething(); 
}

class EffectiveDoer extends Doer {
  void doSomething() {
    print('实现抽象类的方法：$name');
  }
}

void testAbastractClass() {
  var obj = EffectiveDoer();
  obj.name = '抽象类';
  obj.doSomething();
}