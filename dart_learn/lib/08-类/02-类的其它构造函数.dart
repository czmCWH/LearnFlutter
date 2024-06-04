/* 4、Factory constructors 工厂构造函数
* 
* 在实现构造函数时使用 factory 关键字，该构造函数并不总是创建其类的新实例。
* 例如，工厂构造函数可能从缓存返回一个实例，也可能返回一个子类型的实例。
* 
* 
*/


/* 5、Constant constructors 常量构造函数
*  
* 定义 const 构造函数，需确保类的所有实例变量为 final。
*/
class ConstClass {
  static const ConstClass origin = ConstClass(0, 0);

  final double x, y;

  const ConstClass(this.x, this.y);
}

