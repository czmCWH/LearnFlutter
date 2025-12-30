/* 
 <https://dart.cn/language/mixins>
 <https://dart.ac.cn/language/mixins>

mixin 声明要求 Dart3.0+。 早期版本中的代码通常使用 abstract class 代替。 
⚠️ Mixin 是一种定义代码的方式，这些代码可以在多个类层次结构中复用。它们旨在大量提供成员实现。

1、mixins 混入
  - 定义 mixin 的语法如下：
    mixin 名称A {
      // 成员变量...
      // 成员方法...
    }

  - 要使用 mixin，请使用 with 关键字，后跟一个或多个混入名称， 并且 with 用在 extends 之后。使用 mixin 的语法如下：
    class 类名称 [extends 父类名称] with 名称A, 名称B... {
    
    }

  - 另外，在极少数情况下，可能需要同时定义 mixin 和 类，则可以使用 mixin class 来声明。
  
2、mixin 的特点
  - mixin 中可以定义字段、方法、getter/setter 方法。
  - 定义 mixin 和 mixin class 不能有 extends子句，也不能声明任何生成构造函数。

3、如何指定 mixin 可以调用的 自身成员？
 有时 mixin 需要能够调用方法或访问字段，但自身却无法定义这些成员（因为 mixin 不能使用构造函数参数来实例化自己的字段）。
 有如下几种策略，以确保 mixin 的任何子类都定义了 mixin 行为所依赖的任何成员：
  
  - 方法1，在 mixin 中定义抽象成员。这样可以强制所有使用该 mixin 的类型定义其行为所依赖的抽象方法。

  - 方法2，实现接口，与将 mixin 声明为抽象类似。在混入上添加 implements 子句而不实际实现接口，也将确保为 mixin 定义任何成员依赖。
 
  - 方法3，使用 on 子句声明 mixin 的父类，on 子句强制任何使用该 mixin 的类都必须是 on 子句中定义的类型的子类。
 
 */

void main(List<String> args) {
  print('--- 1、mixin 混入的定义与使用：');
  C c = C();
  c.methodA();
  c.methodB();

}

// ----------------- 1、mixin 混入的定义与使用
mixin A {
  void methodA() => print('打印 A');
}

mixin B on A {
  void methodB() => print('打印 B');
}

// 使用时必须先 with A，再 with B，因为 mixin A 继承自 mixin B
class C with A, B {}


// ----------------- 3.1、在 mixin 中定义抽象成员
mixin Musician {
  void playInstrument(String instrumentName); // 抽象方法
  void doSome() {
    print('--- 普通方法');
  }

  // ⚠️，抽象的 getter 方法，可以使得 mixin 中可以访问其子类上的状态
  String get name;  // 定义 抽象的 getter 方法
  void doDesc() {
    print('--- name = $name');
  }
}

// 使用 Musician 混入的类，必须实现它内部的抽象方法！
class Virtuoso with Musician {
  @override
  void playInstrument(String instrumentName) {
    print('--- playInstrument');
  }

  @override
  final String name;

  Virtuoso(this.name);
}

// ----------------- 3.2、mixin 中使用 implements 子句来确保使用此 mixin 的实现该接口
// 定义抽象接口 Tuner
abstract interface class Tuner {
  void tuneInstrument();
}

// 定义 Guitarist 使用 implements 子句来使用 Tuner 接口
mixin Guitarist implements Tuner {
  void playSong() {
    tuneInstrument();

    print('Strums guitar majestically.');
  }
}

// PunkRocker 使用 Guitarist 混入时，必须实现 Tuner 抽象接口
class PunkRocker with Guitarist {
  @override
  void tuneInstrument() {
    print("Don't bother, being out of tune is punk rock.");
  }
}


// ----------------- 3.3、mixin 混入使用 on 子句来继承
class Animal {
  String name;

  Animal(this.name);

  void move() {
    print('$name is moving.');
  }

  // 假设只有某些动物能拍打翅膀
  void flapWings() {
    print('$name flaps its wings.');
  }
}

mixin Flyable on Animal {
  void fly() {
    super.flapWings();        // 调用父类的方法
    print('$name is flying high!');
  }

  @override
  void move() {
    super.move(); // 调用父类的方法
    fly();       
  }
}

class Bird extends Animal with Flyable {
  Bird(String name) : super(name);
}

// ❌ 报错：因为 Flyable 使用 on 子句继承了 Animal，而 Drone 不是 Animal 的子类，因此不能使用 Flyable。
// class Drone with Flyable {} // 编译错误！


/* 
 4、mixin 类型 和 mixin class 类型
 
 mixin 声明定义了一个 mixin。
 mixin class 声明定义了一个既可用作常规类又可用作 mixin ，具有相同的名称和类型。
 
 任何适用于 class 或 mixin 的限制也适用于 mixin class:
  mixin 不能有 extends 或 with 子句，所以 mixin class 也不能。
  class 不能有 on子句，mixin class 也不能。
 
 */

// 定义一个 mixin class
mixin class Teacher {
  // ...
}

// 把 mixin class 作为 mixin 
class MathTeacher with Teacher { 
  // ...
}

// 把 mixin class 作为类继承
class PhysicsTeacher extends Teacher { 
  // ...
}


