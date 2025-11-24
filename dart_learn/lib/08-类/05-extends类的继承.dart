/* 
 1、类的继承 extends
  <https://dart.cn/language/extend>
  - dart属于单继承，一个类只能拥有一个直接父类，子类拥有父类所有的属性和方法。 
  - Dart 使用 extends 来创建子类，在子类中使用 super 来引用父类。
  - extends 还可以用于泛型，使用 extends 实现参数类型的限制。
  
 2、子类重写父类的方法
  类重写父类的方法作用是扩展其行为。
  子类可以重写实例方法（包括运算符）、getter 和 setter 方法，重写方法用 @override 注解表示。

  重写方法声明必须在以下几个方面与它所重写的方法相匹配：
     1、返回类型必须与被覆盖方法的返回类型相同(或其子类型)。
     2、参数类型必须与重写方法的参数类型相同（或为其超类型）。
     3、如果重写的方法接受n个位置参数，那么重写的方法也必须接受n个位置参数。
     4、泛型方法与非泛型方法不能相互覆盖。
  如果重写了对象的 == 方法，也必须重写 hashCode 方法。
  可以重写 noSuchMethod() 实例方法，用于检测或应对代码尝试使用不存在的方法或实例变量的情况。如果不重写此方法会抛出 NoSuchMethodError 异常。

 3、子类的构造函数
  < https://dart.cn/language/constructors#constructor-inheritance>
  子类不会继承父类的命名构造函数。子类必须通过 super 关键字调用父类构造函数确保父类正确初始化。语法如下：
    子类类名(可选命名参数):super({参数}) {
      // 构造函数体 （可省略）
    }
  
 */

void main(List<String> args) {

  Student s1 = Student(name: '张三', age: 16);
  s1.study();
  
  var p1 = Person(name: 'Alice', age: 30);
  var p2 = Person(name: 'Alice', age: 30);
  print(p1 == p2); // false

  var e1 = Employee(employeeId: 'Bob', age: 25, name: 'E123');
  var e2 = Employee(employeeId: 'Bob', age: 25, name: 'E123');
  print(e1 == e2); // false
}

// ----------------- 1、子类重写父类的实例方法，定义构造函数
class Person {
  String? name;
  int? age;

  Person({this.name, this.age});

  void study() {
    print('父类 $name 在学习！');
  }

   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Person && // 注意：这里是 Person
        name == other.name &&
        age == other.age;
  }

  @override
  int get hashCode => Object.hash(name, age);
}

class Student extends Person {
  // 子类不会继承父类的初始化方法，通过 super 调用父类构造函数
  Student({String? name, int? age}) : super(name: name, age: age) {
    print('初始化子类');
  }

  // 可简写为
  // Student({super.name, super.age}) {
  //   print('初始化子类');
  // }

  @override
  void study() {
    // TODO: implement study
    super.study();
    print('学习好，考大学～');
  }
}

// ----------------- 2、子类重写父类的 setter、getter 方法
// 父类 Animal
class Animal {
  String _name;
  int _age;

  Animal(this._name, this._age);

  // 父类的 getter 方法
  String get name => _name;
  int get age => _age;

  // 父类的 setter 方法
  set age(int value) {
    if (value >= 0) {
      _age = value;
    } else {
      print('年龄不能为负数');
    }
  }
}

class Dog extends Animal {
  String _breed;

  // super 调用父类构造函数
  Dog(String name, int age, this._breed) : super(name, age);

  // 重写父类的 getter 方法，添加品种信息
  @override
  String get name => '${_breed}犬: ${super.name}';

  // 重写父类的 setter 方法，添加年龄限制逻辑
  @override
  set age(int value) {
    if (value <= 20) {
      super.age = value; // 调用父类的 setter
    } else {
      print('狗的年龄不能超过20岁');
    }
  }
}

// ----------------- 3、子类重写父类的 == 和 hashCode
class Employee extends Person {
  final String employeeId;

  Employee({required this.employeeId, super.name, super.age});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    // 关键：确保 other 是 Employee 类型（不是 Person）
    return other is Employee &&
        super == other && // 复用父类的相等逻辑
        employeeId == other.employeeId;
  }

  // Object.hashAll 生成多个对象组合的哈希码
  @override
  int get hashCode => Object.hashAll([super.hashCode, employeeId]);
}


/*
 * extends 还可以用于泛型，使用 extends 实现参数类型的限制。
 */
class Foo<T extends Employee> {
  @override
  String toString() => "Instance of 'Foo<$T>'";
}
