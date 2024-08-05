/* https://dart.cn/language/classes

Dart是一种面向对象的语言，具有 class 和 基于 mixin 的继承。

Dart 类的特点：
 每个对象都是一个 class 的实例，除了 Null 以外的所有 class 都继承自 Object。
 基于 Mixin 的继承 意味着尽管每个类（顶级类 Object? 除外）都只有一个父类，但类主体可以在多个类层次结构中重复使用。
 Extension methods 是一种在不改变类 或 创建子类的情况下向类添加功能的方法。
 Class modifiers 允许您控制库如何对类进行子类型化。

某些构造函数和构造函数的某些部分无法访问 this。这些包括：
  1、Factory constructor 中；
  2、初始化列表的右侧；
  3、父类构造函数的参数；

如果您需要执行一些无法在初始化列表中表示的逻辑，请使用该逻辑创建一个工厂构造函数(或静态方法)，然后将计算值传递给普通构造函数。

构造函数：https://mp.weixin.qq.com/s/dL31ZBu7DYR2mdSqpjUIvQ
  
 */

void main() {

}

/// 1、定义类
class VarClass {
  
  /* 1、声明实例变量
   * nullable type 类型声明的未初始化实例变量的值为 null；使用 ?. 访问来避免空异常。
   * 不可为 null 的实例变量必须在声明时初始化。
   */
  String name = '';
  double? a;
  int b = 0;

  // 2、late 实例变量的初始化器中可以访问 this
  late double? z = this.a;

  /* 3、实例变量可以是 final，它们必须只设置一次。
   * 在声明时，使用构造函数的参数初始化 final 变量。
   * 
   * 如果需要在构造函数主体启动后分配最终实例变量的值，可以使用以下方法之一：   
   *    使用工厂构造函数;
   *    使用 late final，但要小心：没有初始化器的 late final 会向 API 添加 setter。
   */
  final String idTag;
  final DateTime start = DateTime.now();


  /*
   * Dart实现了许多类型的构造函数。除了默认构造函数外，这些函数使用与其类相同的名称。
   * 
   * 1、默认构造函数：如果不声明构造函数，Dart 将使用默认构造函数。默认构造函数是没有参数、名称的 生成构造函数。
   */

   /* 2、Generative constructor 生成构造函数
   * 生成构造函数：与类同名的函数，用来创建类新的实例，并初始化形式参数来实例化任何实例变量。
   * 
   * Initializing formal parameters 初始化形式参数 
   *    是 Dart 用来简化将构造函数参数赋值给实例变量的常见模式。
   *    在构造函数声明中使用 this.propertyName 来省略函数体。
   * 
   * 初始化形式参数 可以初始化 non-nullable 或 final 实例变量。
   * this 表示当前实例。仅在存在名称冲突时使用 this，否则，Dart风格会省略this。
   */
  VarClass(this.a, this.b, this.idTag) {
    print('添加一些初始化逻辑');
  }

  /* 3、Named constructors 命名构造函数
   * 用来为一个类实现多个构造函数；阐明构造函数的用途；
   */
  VarClass.origin()
    : a = 100,
      idTag = '命名构造函数';


   /* Initializer list(初始化列表)
    * 
    * 可以在构造函数体运行之前初始化实例变量。
    * 初始化声明右侧无权访问 this。
    * 如果需要执行一些无法在 初始化列表 中表示的逻辑，请使用该逻辑创建一个工厂构造函数(或静态方法)，然后将计算值传递给普通构造函数。 
    */
  VarClass.fromJSON(Map<String, double> json)
          : a = json['a'],
            b = json['b']!.toInt(),
            idTag = handleSth(json['id'].toString()) {
    print('$idTag, a = $a, b = $b');
  }

  static String handleSth(String e) => e.toUpperCase();

  VarClass.from(double a, int b, String idTag): a = a, b = b, idTag = idTag {
    print('初始化列表');
  }

  // 初始化形式参数也可以是可选的。
  VarClass.optional(this.idTag, [this.a = 1.23, this.b = 2]);

  // 使用默认值初始化形式参数的生成构造函数
  VarClass.idTag({required int b, this.idTag = '哈哈'});


  /* 5、Redirecting constructors 重定向构造函数
   *  用于重定向到同一类中的另一个构造函数。
   *  重定向构造函数的主体为空，在冒号之后使用 this 调用构造函数。
   */  
  VarClass.fromA(double a) : this(a, 100, '重定向构造函数');


  

  /* 1、实例方法
   * 对象的实例方法可以访问 实例变量 和 this。
   */
  void doSome() {
    print('--- 实例方法：${this.a ?? 1.23}');
  }

  /* 2、getter 和 setter 方法
   * 每个实例变量都有一个隐式的 getter，如果为非 final 属性的话还会有一个 setter。 
   * 可以通过使用 get 和 set 关键字实现 getter 和 setter 来创建其他属性。
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


