
# 抽象类、继承、Mixin


### `Abstract classes` 抽象类

使用 `abstract` 修饰符定义一个`abstract class`(抽象类) --- 抽象类无法实例化。 

抽象类常用于声明接口方法、有时也会有具体的方法实现。如果希望抽象类能够被实例化，请定义一个`factory constructor`(工厂构造函数)。

抽象类通常具有抽象方法。下面是一个声明具有抽象方法的抽象类的示例： 

```Dart
abstract class Dog {
  String speak();
}
```

#### 抽象方法

实例方法、`getter`和`setter`方法都可以是抽象的，只定义接口不进行实现，而是留给其他类去实现。抽象方法只能存在于 `abstract classes`(抽象类)中。

定义一个抽象函数，使用分号 (;) 来代替函数体：

```Dart
abstract class Doer {
  void doSomething(); // 定义一个抽象方法。
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // 提供方法实现，所以这里的方法就不是抽象方法了...
  }
}
```

### 隐式接口

每个类都隐式的定义了一个接口，该接口包含了该类所有的 实例成员 及其 实现的接口。如果要创建一个 A 类，A 要支持 B 类的 API ，但是不需要继承 B 的实现， 那么可以通过 A 实现 B 的接口。

一个类可以通过 `implements` 关键字来实现一个或者多个接口，并实现每个接口要求的 API。 例如：

如下 `Teach` 类的 `Implicit interfaces`(隐式接口) 包含实例成员 `subName` 和  `subject`，以及 `jobDescription` 接口：

```Dart
class Teach {
  final subName;
  String subject;
  
  Teach(this.subName, this.subject);
  
  String jobDescription() => "$subName teach $subject";
}
```

如下 `Person` 类实现 `Teach` 类的接口：

```Dart
class Person implements Teach {
  
  get subName => '机械工';
  String get subject => '机器控制';
  set subject(String value) { }
  
  String jobDescription() => "$subName direct $subject subjects";
}
```

由于 `Person` 实现了 `Teach` 的接口，所以可以当作 `Teach` 类型进行传递：

```Dart
void teachTest(Teach obj) {
  print(obj.jobDescription());
}

var t = Teach('老师', '数学');
teachTest(t);

var p = Person();
teachTest(p);
```

## 扩展类（继承）

使用 `extends` 创建一个子类，并使用 `super` 来引用父类：

子类可以覆盖实例方法(包括运算符)、`getter`和`setter`。可以使用 `@override` 批注指示您有意覆盖成员

定一个 `Animal` 子类：

```Dart
class Animal {
  String type;
  int age;
  
  Animal(this.type, this.age);
  
  void eat(String food) {
    print('eat $food');
  }
  
  void sport(String name) {
    print('sport $name');
  }
}
```

`Person`类继承自 `Animal`：

```Dart
class Person extends Animal {
  
  // 重写属性
  String get type => '高级动物';
  
  String name = '';
  
  // 构造函数
  Person(String name, String type, int age): super(type, age) {
    this.name = name;
  }
  
  // super 关键字引用一个父类
  void eat(String food) {
    super.eat(food);
    print('干饭人！');
  }
  
  // 重写方法
  @override
  void sport(String name) {
    print('我喜欢 $name 运动！');
  }
}
```

### noSuchMethod() 方法

当在代码尝试使用不存在的方法或实例变量时，可以重写`noSuchMethod()`，来进行检测或作出反应。

```Dart
class A {
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: ' +
        '${invocation.memberName}');
  }
}

dynamic a = A();
print(a.name);
// 打印：You tried to use a non-existent member: Symbol("name")
null
```

除非满足以下条件之一，否则您不能调用未实现的方法：

* `receiver` 具有`dynamic`的静态类型。

* `receiver` 具有静态类型，用于定义为实现的方法 (可以是抽象的), 并且 `receiver` 的动态类型具有 `noSuchMethod()` 的实现， 该实现与 `Object` 类中的实现不同。

有关更多信息，请参见[noSuchMethod forwarding specification](https://github.com/dart-lang/sdk/blob/master/docs/language/informal/nosuchmethod-forwarding.md)。

## 扩展方法

[Extension methods](https://dart.cn/guides/language/extension-methods)(扩展方法)是向现有库添加功能的一种方法。您可能会在不知情的情况下使用扩展方法。例如，当您在IDE中使用代码完成时，它建议使用扩展方法和常规方法。

```Dart
import 'string_apis.dart';

print('42'.padLeft(5)); 
print('42'.parseInt()); 
```

## 使用 Mixin 为类添加功能

* `mixin`(混合) 是一种在多个类层次结构中重用类代码的方法。

* 使用 `with` 关键字并在其后跟上 `Mixin 类的名字` 来使用 Mixin 模式。

* 通过创建一个继承自 `Object` 且 `没有构造函数` 的类，来实现 一个 `mixin`。如果 `mixin` 不希望作为常规类被使用，使用关键字 `mixin` 替换 `class` 。

```Dart
class Machine {
  bool isOil = false;
  
  void work() {
    print("使用机器工作");
  }
}

mixin Tool {
  List<String> some = ['铁锹', '锤子'];
  
  String giveTool() {
    String tools = '';
    for(var item in this.some) {
      tools += (item + ', ');
    }
    return tools;
  }
}
```

```Dart
class Worker with Machine, Tool {
  String name;
  Worker(this.name);
}

var w = Worker('工人');
w.work();       // 打印：使用机器工作
print('${w.giveTool()}');   // 打印：铁锹, 锤子, 
```

```Dart
class Animal {
  String sex;
  
  Animal(String sexStr): sex = sexStr; 
  
  Animal.orl(): sex = "ds"; 
}

class Monkey with Animal { }        // 报错：因为 Animal 有自定义构造函数
```

* 指定只有某些类型可以使用的 `Mixin`。

例如，Mixin 可以调用 Mixin 自身没有定义的方法。 如下例所示，通过使用`on`关键字指定所需的父类来限制 `mixin` 的使用：

```Dart
class A {
  void test() {
    print('begin test');
  }
}
// 指定 B 只能被 A 使用
mixin B on A {
  void build() {
    test();
    print('begin build');
  }
}

class Cc extends A with B { }

var c = Cc();
c.build();
// 打印：begin test     begin build
```

>  mixin 关键字在 Dart 2.1 中被引用支持。 早期版本中的代码通常使用 abstract class 代替。 
