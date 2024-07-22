/* https://dart.cn/language/classes
 * 
 * Dart 是一种面向对象的语言，具有类和基于 mixin 的继承。
 * 
 * Dart 类的特点：
 *  每个对象都是一个类的实例，除了Null以外的所有类都继承自object。
 *  基于 Mixin 的继承 意味着尽管每个类（顶级类 Object 除外）都只有一个超类，但类主体可以在多个类层次结构中重复使用。
 *  Extension methods 是一种在不改变类或创建子类的情况下向类添加功能的方法。
 *  Class modifiers 允许您控制库如何对类进行子类型化。
 * 
 */

void main() {

}

/*
1、定一个 类
Dart 的类都继承自 Object。
 */
class VarClass {
  
  /* 1、声明实例变量
   * nullable type 类型声明的未初始化实例变量的值为 null。
   * 不可为 null 的实例变量必须在声明时初始化。
   */
  String name = '';
  double? a;
  int b = 0;

  // 2、late 实例变量的初始化器中可以访问 this
  late double? z = this.a;

  /* 3、实例变量可以是 final，它们必须只设置一次。
   * 在声明时，使用构造函数的参数初始化final 变量。
   * 
   * 如果需要在构造函数主体启动后分配最终实例变量的值，可以使用以下方法之一：   
   *    使用工厂构造函数;
   *    使用 late final，但要小心：没有初始化器的 late final 会向 API 添加 setter。
   */
  final String idTag;
  final DateTime start = DateTime.now();


  //  注意：构造函数不可继承。

  /* 1、Generative constructor 生成构造函数
   * 生成构造函数：与类同名的函数，用来创建类新的实例，并初始化形式参数来实例化任何实例变量。
   * 
   * Initializing formal parameters 初始化形式参数 
   *    是 Dart 用来简化将构造函数参数赋值给实例变量的常见模式。
   *    在构造函数声明中使用 this.propertyName 来省略函数体。
   * 
   * 初始化形式参数 可以初始化 non-nullable 或 final 实例变量。
   * this 表示当前实例。仅在存在名称冲突时使用 this，否则，Dart风格会省略this。
   */
  VarClass(this.a, this.b, this.idTag);

   /* 2、Initializer list(初始化列表)
    * 
    * 可以在构造函数体运行之前初始化实例变量。
    * 初始化声明右侧无权访问 this。
    * 如果需要执行一些无法在 初始化列表 中表示的逻辑，请使用该逻辑创建一个工厂构造函数(或静态方法)，然后将计算值传递给普通构造函数。 
    */
  VarClass.fromJSON(Map<String, double> json)
          : a = json['a'],
            b = json['b']!.toInt(),
            idTag = '通过初始化列表创建对象' {
    print('$idTag, a = $a, b = $b');
  }

  VarClass.from(double a, int b, String idTag): a = a, b = b, idTag = idTag {
    print('初始化列表');
  }


  /* 3、Named constructors 命名构造函数
   * 用来为一个类实现多个构造函数，也可以更清晰的表明函数意图。
   */
  VarClass.origin()
    : a = 100,
      idTag = '命名构造函数';

  /* 4、Redirecting constructors 重定向构造函数
   *  用于重定向到同一类中的另一个构造函数。
   *  重定向构造函数的主体为空，在冒号之后使用 this 调用构造函数。
   */  
  VarClass.fromA(double a) : this(a, 100, '重定向构造函数');


  /* 5、命名工厂构造方法
   * 语法：
   *    factory 类名.方法名
   * 它可以有返回值，而且不需要将类的 final 变量作为参数，是提供一种灵活获取类对象的方式。
   */


  /* 6、工厂构造方法
   * 
   */


  /* 1、实例方法
   * 对象的实例方法可以访问 实例变量 和 this。
   */
  void doSome() {
    print('--- 实例方法：${this.a ?? 1.23}');
  }

  /* 2、getter 和 setter 方法
   *    每个实例变量都有一个隐式的 getter，如果为非 final 属性的话还会有一个 setter。 
   *    可以通过使用 get 和 set 关键字实现 getter 和 setter 来创建其他属性。
   */
  Map<String, String> get introduce {
    return {"name": this.name, "a": (this.a ?? 1.22).toString()};
  }

  set introduce(Map<String, String> value) {
    this.name = value["name"] ?? '实例变量 introduce 的 setter 方法赋值。';
    this.a = double.parse(value["a"] ?? '0.11');
  }

  double get realA => this.a ?? 1.23;

  /* 3、Operators
   * Operators 是具有特殊名称的实例方法。
   */
  VarClass operator +(VarClass v) => VarClass((a ?? 0) + (v.a ?? 0), b + v.b, '加法后的对象');



  /* 1、类变量和类方法
   * 使用 static 关键字声明 类变量 或 类方法。
   * 
   * 1.1、类变量
   * 类变量常用于声明类范围内所属的状态变量和常量。
   * 类变量在使用之前不会被初始化。
   *
   * 1.2、类方法
   * 类方法不对实例进行操作，因此不能访问实例 this。
   * 类方法中可以访问类变量。
   * 对于常见或广泛使用的实用程序和功能，请考虑使用顶级函数，而不是静态方法。
   */
  
  static var total = 16;
  static const initialName = '类常量';

  static String classDesc() {
    return '类方法：total = $total, $initialName';
  }

  // 1、重写方法
  @override
  String toString() {
    return 'name = $name';
  }

}


void testUseClass() {
  
  print('obj1:');
  var obj1 = VarClass(null, 111, '生成构造函数实例化对象');
  print('a = ${obj1.a}, b = ${obj1.b}, idTag = ${obj1.idTag}');

  var objList = VarClass.fromJSON({'a': 100.0, 'b': 200.0});

  print('obj2:');
  var obj2 = VarClass.origin();
  print('a = ${obj2.a}, b = ${obj2.b}, idTag = ${obj2.idTag}');

  print('obj3:');
  var obj3 = VarClass.fromA(222);
  print('a = ${obj3.a}, b = ${obj3.b}, idTag = ${obj3.idTag}');

  
  /* 1、获取对象的类型
   * 
   * 可以使用 object 属性runtimeType 来 获取对象的类型。
   * 在生产环境中，使用 object is Type 比 runtimeType 更稳定。
   */

}