/* 
 <https://dart.cn/language/class-modifiers#abstract>
 <https://dart.cn/language/methods#abstract-methods>

 1、abstract class 抽象类
  使用 abstract 修饰符 来定义抽象类。抽象类的特点如下：
   - 抽象类不能被实例化；
   - 抽象类通常具有抽象方法（即没有方法体的方法），抽象方法必须被子类实现。
   - 抽象类可以像普通类一样，定义属性、方法、getter/setter、构造函数等。
   - 抽象类只能被 extends 继承。

 2、抽象方法的特点
   抽象方法只能存在于 abstract classes(抽象类) 或  mixins(混入) 中；
   要使方法抽象化，请使用分号（;）代替方法主体；
   实例方法、getter 和 setter 方法都可以是抽象的，只定义接口不进行实现，而是留给其他类去实现；

 3、抽象类的作用
  主要用于定义接口规范 或 提供部分通用实现，强制子类实现抽象方法。它是面向对象设计中实现多态和代码复用的重要工具。
 
 */

void main(List<String> args) {
  
  // // Dart 多态实现方式2 --- 抽象类
  Animal dog = Dog('Buddy', age: 10);
  Animal cat = Cat('Whiskers', age: 12);

  dog.introduce(); // Hi, I am Buddy. \n Woof! Woof!
  cat.introduce(); // Hi, I am Whiskers. \n Meow~
}

// 定义抽象类 Animal
abstract class Animal {
  // 抽象方法：没有方法体，以分号结尾。--- 子类必须重写实现
  void makeSound();

  // 具体方法：有方法实现，子类可直接使用或重写。--- 子类可继承，用于表示通用的实现～
  void introduce() {
    print('Hi, I am $name.');
    makeSound(); // 调用子类实现的抽象方法
  }

  // 抽象 getter 方法
  String get name;

  // 实例属性
  int age = 0;

  // 构造函数
  Animal({ required this.age });
}

class Dog extends Animal {
  @override
  final String name;

  Dog(this.name, {required super.age});

  @override
  void makeSound() {
    print('Woof! Woof!');
  }
}

class Cat extends Animal {
  @override
  final String name;

  Cat(this.name, {required super.age});

  @override
  void makeSound() {
    print('Meow~');
  }
}