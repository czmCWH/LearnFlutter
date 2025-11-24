/* 
https://dart.cn/language/classes

Dart是一种面向对象的语言，它使用 class 和 基于 mixin 的继承机制。


class 的特点：
 每个对象都是一个 class 的实例，除了 Null 以外的所有类 都继承自 Object。
 基于 Mixin 的继承 意味着尽管每个类（顶级类 Object? 除外）都只有一个直接父类，但类主体可以在多个类层次结构中重复使用。
 Extension methods 是一种在不改变类 或 创建子类的情况下向类添加功能的方法。
 Class modifiers 允许您控制库如何对类进行子类型化。

对象（实例）包含由函数和数据（分别称为方法和实例变量）组成的成员。
 */
void main(List<String> args) {
  /* 
   1、初始化一个实例，访问其属性、方法
   
    a、获取实例的类型 ⚠️ 
     可以使用 object 属性runtimeType 来 获取对象的类型。
     在生产环境中，使用 object is Type 比 runtimeType 更稳定。
    
    b、直接 print 实例会调用起 toString 方法，可以重写此方法。
   */
  Student st = Student(1.75, '高中');
  st.name = '张三';
  st.age = 16;
  // 初始化 late 实例属性
  st.school = '某市高级中学';

  print('st 变量的类型：${st.runtimeType}, ${st is Student}');  // Student, true
  print(st);   // 如果不重写 toString 方法，则输出：Instance of 'Student'


  // 2、实例变量的 getter 和 setter 方法
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);

}


// ------ 1、定义类的实例属性、实例方法
class Student {
  /* 
   1、定义实例属性(变量)
    nullable type （可空类型）的实例属性默认初始值为 null，需使用 ?. 访问来避免空异常。
    Non-nullable（非空类型）的实例属性，必须在声明时初始化，或在构造函数中初始化。如：name、height。
    late 延迟初始化属性，属性的初始化会推迟到首次访问时。
   */
  String name = '';
  double height;
  int? age;
  late String school;
  
  /* 
   final 实例变量 ⚠️
     final 实例变量是一个运行时常量，只能赋值一次。
     final 的 non-late 的实例变量，必须在 声明时 或者 构造函数的初始化列表 中初始化。
     
   如果在构造函数体开始之后需要给 final 实例变量赋值，可以使用以下方法之一：
     使用工厂构造函数;
     使用 late final，但要小心：没有初始化器的 late final 会向 API 添加 setter。
   */
  final DateTime start = DateTime.now();
  final String idTag;
  late final String config = loadConfig();

  Student(this.height, this.idTag);

  // 实例方法
  String loadConfig() {
    this._eat();
    return '加载配置';
  }

  /*
    ⚠️：2、类中的私有属性、私有方法都是以下划线开头命名，只能在类中使用。
   */
  String? _value;

  void _eat() {
    print(this._value);
  }

  @override
  String toString() {
    // 注意：school 是 late，如果未初始化会 crash！
    // 为安全起见，可加判断（但 Dart 不允许对 late 字段判 null）
    // 所以应确保在 toString() 调用前已赋值 school
    return 'Student('
        'name: "$name", '
        'height: $height, '
        'age: $age, '
        'school: $school, '
        'start: $start, '
        'idTag: "$idTag", '
        'config: "$config"'
        ')';
  }

  /* 3、Operators
   * Operators 是具有特殊名称的实例方法。
   */
  Student operator +(Student v) => Student(height + v.height, '加法后的对象');
}


// ------ 2、实例变量的 getter 和 setter 方法
/* 
  getter 和 setter 方法
    所有实例变量都生成一个隐式getter方法。
    非 final 实例变量 和 未初始化的 late final 实例变量 也会生成一个隐式的 setter 方法。
    可以通过使用 get 和 set 关键字实现 getter 和 setter 来创建其他属性。
 */
class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // 定义两个计算属性
  double get right => left + width;
  set right(double value) => left = value - width;

  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

// ------- 3、类变量与类方法
class Animal {
  /* 
    1、类变量和类方法
     使用 static 关键字声明 类变量 或 类方法。
     
     1.1、类变量
     类变量 常用于声明类范围内所属的状态变量和常量。
     静态变量只有在使用时才会初始化。
    
     1.2、类方法
     类方法不能操作实例，因此类方法内不能访问实例 this。
     类方法中可以访问类变量 和 其它类方法。
     对于常见或广泛使用的实用程序和功能，请考虑使用顶级函数，而不是静态方法。
   */
  static var total = 16;
  static const initialName = '类常量';

  static String classDesc() {
    return '类方法：total = $total, $initialName';
  }
}