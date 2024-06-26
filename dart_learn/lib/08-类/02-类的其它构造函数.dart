/* 
* https://dart.cn/language/constructors#invoking-a-non-default-superclass-constructors
* 4、Factory constructors 工厂构造函数
* 
* 在实现构造函数时使用 factory 关键字，该构造函数并不总是创建其类的新实例。
* 例如，工厂构造函数可能从缓存返回一个实例，也可能返回一个子类型的实例。
* 
* 
*/


/* 
   * 2、默认构造函数
   * 如果不声明构造函数，则 Dart 提供默认构造函数。默认构造函数没有参数，并调用父类中的无参数构造函数。
   * 子类不会从其超类继承构造函数。没有声明构造函数的子类只有默认的（没有参数，没有名称）构造函数。
   * 如果您需要执行一些无法在初始化列表中表示的逻辑，请使用该逻辑创建一个工厂构造函数(或静态方法)，然后将计算值传递给普通构造函数。
   */



/* 5、Constant constructors 常量构造函数
*  
* 定义 const 构造函数，需确保类的所有实例变量为 final。
* 要使用常量构造函数创建编译时常量，请将 const 关键字放在构造函数名称之前。
* 
* 常量构造函数创建的实例并不总是常量。
*
*/
class ConstClass {
  static const ConstClass origin = ConstClass(0, 0);

  final double x, y;

  const ConstClass(this.x, this.y);
}

