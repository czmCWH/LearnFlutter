
/* 
<https://dart.cn/language/constructors#invoking-a-non-default-superclass-constructors>
<https://ducafecat.com/blog/3-tips-for-improving-your-flutter-code-quality>
*/

import 'dart:convert';

void main() {
  testConstant();
  testFactory();
}

/* 4、Constant constructors 常量构造函数
 * 用于类生成不变的对象。该对象为编译时常量。
 * 需定义一个 const 构造函数，并且需确保类的所有实例变量为 final
 * 
 * 常量构造函数创建的实例并不总是常量。。
 */ 
class ConstantPoint {
  static const ConstantPoint origin = ConstantPoint(0, 0);

  final double x, y;

  /// 定义常量构造函数  
  const ConstantPoint(this.x, this.y); 
}

void testConstant() {

  // 4.1、要使用常量构造函数创建编译时常量，请将 const 关键字放在构造函数名称之前。
  var c1 = ConstantPoint(10, 20);   // 此时创建的是一个非常量对象
  var c2 = const ConstantPoint(10, 20);
  var c3 = const ConstantPoint(10, 20);

  // identical：检查两个对象引用是否指向同一个对象
  print('c1 == c2: ${identical(c1, c2)}');  // c1 == c2: false
  print('c2 == c3: ${identical(c2, c3)}');  // c2 == c3: true

  // 4.2、在常量上下文中，您可以省略构造函数或文字之前的 const。
  const line1 = const {
    'point': const [const ConstantPoint(0, 0)],
    'line': const [const ConstantPoint(1, 10), const ConstantPoint(-2, 11)],
  };

  const line2 = {
    'point': [ConstantPoint(0, 0)],
    'line': [ConstantPoint(1, 10), ConstantPoint(-2, 11)],
  };
  print('line1 == line2: ${identical(line1, line2)}');  // line1 == line2: true

}

/* 6、Factory constructors 工厂构造函数
 * 当实现构造函数遇到以下两种情况之一时，请使用factory关键字：
 *    1、构造函数并不总是创建其类的新实例。尽管 factory constructor 不能返回 null，但它可能会返回：
 *        > 从缓存中获取现有实例，而不是创建新实例;
 *        > 子类型的新实例
 *    2、在构造实例之前，需要执行一些重要的工作。如：检查参数；执行任何其他无法在初始化列表中处理的处理。
 * 
 * 语法：
 *    factory 类名.方法名
 * 
 * Factory constructors 中不能访问 this。
 */
class FactoryHuman {
  String name;
  double height;

  FactoryHuman(this.name, this.height);

  factory FactoryHuman.fromJson(Map<String, Object> json) {
    String n1 = json["name"]?.toString() ?? '';
    double h1 = double.parse(json["height"]?.toString() ?? '');
    return FactoryHuman(n1, h1);
  }

}

void testFactory() {
  var h1 = FactoryHuman.fromJson({'name': '张山', 'height': 1.23});
  var h2 = FactoryHuman.fromJson({'name': '张山', 'height': 1.23});
  print('h1 == h2: ${identical(h1, h2)}');    // 打印：h1 == h2: false
}


/*
 * 👉 构造函数和继承
 * 子类不会从其父类继承构造函数。
 * 
 * Dart 按以下顺序执行构造函数：
 *  1、先 initializer list
 *  2、执行父类的没有命名、没有参数构造函数(或者父类其它构造函数)
 *  3、主类的无参数构造函数
 * 
 * <https://dart.cn/language/constructors/>
 * 
 */

class Creature {
  String family;
  int age;

  Creature({required this.family, required this.age});
}

class Man extends Creature {
  String name;

  Man(this.name) : super(family: '', age: 0);
}





