/*
https://dart.cn/language/constructors
https://ducafecat.com/blog/3-tips-for-improving-your-flutter-code-quality

构造函数是创建类实例的特殊函数。Dart 实现了多种类型的构造函数。构造函数名称可以是 `类名` 或 `类名.标识符`。

实例变量初始化有如下3种方式：
  方式1、在声明时初始化实例变量；
  
  方式2、使用 initializing formal parameters（初始化形式参数）；
    - 此方式用于简化将构造函数参数赋值给实例变量的常见模式；
    - 语法：
        构造函数名(this.propertyName1, this.propertyName2...) {
          // 构造函数体，注意，构造函数体可以被省略
        }
    - 某些构造函数及其某些部分无法访问 this：
      1、工厂构造器中；
      2、初始化列表的右侧；
      3、传递给父类构造函数的参数；
    - 初始化形式参数 可以初始化 非空实例变量 或 final 实例变量，这两种类型的变量都需要 初始化 或 设置默认值。⚠️⚠️
    - 私有字段不能用作 named initializing formals.
  
  方式3、使用初始化列表；
    初始化器列表在构造函数体运行之前设置实例变量。初始化器之间用逗号分隔。
    语法：
        构造函数名(type name1, type name2,...) : propertyName1 = name1, propertyName2 = name2 ... {
          // 构造函数体（可省略）
        }
    初始化列表有助于 final 属性的初始化。⚠️⚠️
 
 */

import 'dart:convert';

void main(List<String> args) {

//  Person p = Person('张三', 18, '男', 1.75);
//  print(p);

  Person p = Person(name: '张三', sex: '男', height: 1.85);
  print(p);

  Person p2 = Person.origin(name: '李四', sex: '男', age: 32);
  print(p2);


  print("--------------- 常量构造函数：");
  /* 
   使用常量构造函数：
     要使用常量构造函数创建编译时常量，请将 const 关键字放在构造函数名称之前。 
   */
  var c1 = ConstantPoint(10, 20);   // 此时创建的是一个非常量对象
  var c2 = const ConstantPoint(10, 20);
  var c3 = const ConstantPoint(10, 20);

  // ⚠️：identical：检查两个对象引用是否指向同一个对象
  print('方式1, c1 == c2: ${c1 == c2}');  // c1 == c2: false
  print('方式2, c1 == c2: ${identical(c1, c2)}');  // c1 == c2: false
  print('c2 == c3: ${identical(c2, c3)}');  // c2 == c3: true

   // 4.2、在常量上下文中，可以省略构造函数或文字之前的 const。
  const line1 = const {
    'point': const [const ConstantPoint(0, 0)],
    'line': const [const ConstantPoint(1, 10), const ConstantPoint(-2, 11)],
  };

  const line2 = {
    'point': [ConstantPoint(0, 0)],
    'line': [ConstantPoint(1, 10), ConstantPoint(-2, 11)],
  };
  print('line1 == line2: ${identical(line1, line2)}');  // line1 == line2: true

  
  print("--------------- 工厂函数：");

  var h1 = FactoryHuman.fromJson({'name': '张山', 'height': 1.23});
  var h2 = FactoryHuman.fromJson({'name': '张山', 'height': 1.23});
  print('h1 == h2: ${identical(h1, h2)}');    // 打印：h1 == h2: false

}


class Person {
  /*
   1、Generative constructor 生成式构造函数（基本构造函数）
    与类同名的函数，用来创建类新的实例，并初始化形式参数来实例化任何实例变量。
    语法：
       类名(必要位置参数 | 命名参数) {
          // 构造函数体 （可省略）
       }
    
    ⚠️：
     一个类不能同时拥有两个未命名的构造函数。即，ClassName(param1, param2); 和 ClassName({param1, param2}); 只能存在一个。
     Dart 要求所有非空属性在 构造函数体 执行前必须被初始化。
   
    Default constructors 默认构造函数
      如果不声明构造函数，Dart 将使用默认构造函数。默认构造函数是没有参数、名称的 生成式构造函数。

   */

  /*
    解析：
      非空属性 name、final 属性 sex 必须在声明时初始化、初始化形式参数、初始化列表 完成初始化；
      可空属性 age、late final 属性 height 可以在构造函数体中初始化；
  */
  String name;
  int? age = 0;
  final String sex;
  late final double height;

  // 👉 1.1、基本构造函数：类名(必要位置参数)
  // Person(this.name, int age, this.sex, double height) {
  //   this.age = age;
  //   this.height = height;
  // }
  // 直接在参数列表中初始化所有变量，如上可以简写为：
  // Person(this.name, this.age, this.sex, this.height);

  // 👉 1.2、基本构造函数：类名(命名参数)
  Person({required this.name, int? age, required this.sex, required double height}) {
    this.age = age;
    this.height = height;
  }
  // 如上可以使用 语法糖 简写为：
  // Person({required this.name, this.age, required this.sex, required this.height}) {
  //   print('使用初始化形式参数，简写构造函数');
  // }

  
  /*
    👉 2、Named constructors 命名构造函数，用于为一个类实现多个构造函数，提高代码清晰度。
    定义语法：
           类名.构造函数名(必要位置参数 | 命名参数) {
             // 构造函数体 （可省略）
           }     
   */
  // Person.origin({required this.name, int? age, required this.sex}) {
  //   this.age = age;
  // }
  // 如上可以使用 语法糖 简写为：
  Person.origin({required this.name, this.age, required this.sex}) {
    print('使用初始化形式参数，简写构造函数');
  }

}

/*
👉 3、Constant constructors 常量构造函数
  如果类生成的是不变的对象，则将这些对象设为编译时常量。const 构造函数用于创建 编译时常量的对象。
  const 构造函数要求类的所有实例变量必须为 final。
  语法：const 类名(...)，
*/
class ConstantPoint {
  static const ConstantPoint origin = ConstantPoint(0, 0);

  final double x, y;

  /// 定义常量构造函数  
  const ConstantPoint(this.x, this.y); 
}

/*
👉 4、Redirecting constructors 重定向构造函数
   重定向构造函数会重定向到同一类中的另一个构造函数，并且其函数体为空。
   语法：
      重定向构造函数名(type name1, ...) : this(nam1....);
 
 */
class Point {
  double x, y;
  // The main constructor for this class.
  Point(this.x, this.y);

  // Delegates to the main constructor.
  Point.alongXAxis(double x) : this(x, 0);

}

/* 
 👉 5、Factory constructors 工厂构造函数
   当实现构造函数遇到以下两种情况之一时，请使用factory关键字：
      1、构造函数并不总是创建其类的新实例。尽管 factory constructor 不能返回 null，但它可能会返回：
          > 从缓存中获取现有实例，而不是创建新实例;
          > 子类型的新实例
      2、在构造实例之前，需要执行一些重要的工作。如：检查参数；执行任何其他无法在初始化列表中处理的处理。
   
   语法：
      factory 类名.方法名
   
   Factory constructors 特点：
     - 工厂构造函数中不能访问 this，因为对象尚未确定。
     - 必须返回一个该类（或子类）的实例
     - 可以有任意逻辑（if/switch/async 等）

 */
class FactoryHuman {
  String name;
  double height;

  FactoryHuman(this.name, this.height);

  // 工厂构造函数：从 JSON Map 构建 User
  factory FactoryHuman.fromJson(Map<String, Object> json) {
    String n1 = json["name"]?.toString() ?? '';
    double h1 = double.parse(json["height"]?.toString() ?? '');
    return FactoryHuman(n1, h1);
  }
}


abstract class Animal {
  void speak();

  // 工厂根据类型返回具体子类
  factory Animal(String type) {
    switch (type.toLowerCase()) {
      case 'dog':
        return Dog();
      case 'cat':
        return Cat();
      default:
        throw ArgumentError('Unknown animal: $type');
    }
  }
}

class Dog implements Animal {
  @override
  void speak() => print('Woof!');
}

class Cat implements Animal {
  @override
  void speak() => print('Meow!');
}