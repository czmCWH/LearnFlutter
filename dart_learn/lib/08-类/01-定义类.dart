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


/* 1、类的成员
 * 
 */

class VarClass {
  
  /* 1、声明实例变量
   * nullable type 类型声明的未初始化实例变量的值为 null。
   * 不可为 null 的实例变量必须在声明时初始化。
   */
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

  /* 4、Generative constructor 生成构造函数
   * 生成构造函数：通过创建一个与类同名的函数来声明构造函数。
   * 
   * Dart通过 初始化形式参数 用来简化将构造函数参数赋值给实例变量的常见模式。
   * 初始化形式参数 可以初始化 non-nullable 或 final 实例变量。
   * this 表示当前实例。仅在存在名称冲突时使用 this，否则，Dart风格会省略this。
   *  
   */
  VarClass(this.a, this.b, this.idTag);

  /* 
   * 如果不声明构造函数，则 Dart 提供默认构造函数。默认构造函数没有参数，并调用父类中的无参数构造函数。
   * 子类不会从其超类继承构造函数。没有声明构造函数的子类只有默认的（没有参数，没有名称）构造函数。
   * 如果您需要执行一些无法在初始化列表中表示的逻辑，请使用该逻辑创建一个工厂构造函数(或静态方法)，然后将计算值传递给普通构造函数。
   */

  /* 5、Named constructors 命名构造函数
   * 
   * 
   */
  

  

}