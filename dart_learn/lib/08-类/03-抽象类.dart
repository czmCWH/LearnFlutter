/* 1、Abstract methods 抽象方法
 * 
 * 实例、getter和setter方法可以是抽象的，定义一个接口，但将其实现留给其他类。
 * 抽象方法只能存在于抽象类或混合中。
 * 
 * 要使方法抽象化，请使用分号（;）代替方法主体。
 * 
 */

abstract class Doer {
  // Define instance variables and methods...

  void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // Provide an implementation, so the method is not abstract here...
  }
}