/* extends 继承
 * 
 * Dart 使用 extends 来创建子类，使用 super 来引用父类。
 * extends 还可以用于泛型，使用 extends 实现参数类型的限制。
 * 
 * 子类使用 @override 重写父类的方法。
 * 重写方法声明必须以以下几种方式匹配它所重写的方法:
 *    1、返回类型必须与被覆盖方法的返回类型相同(或其子类型)。
 *    2、参数类型必须与重写方法的参数类型相同（或为其超类型）。
 *    3、如果重写的方法接受n个位置参数，那么重写的方法也必须接受n个位置参数。
 *    4、泛型方法与非泛型方法不能相互覆盖。
 * 
 */

/* 
 * https://dart.cn/language/constructors#invoking-a-non-default-superclass-constructor
 * 非默认超类构造函数
 */


class Animals {
  String species = '物种';
  int? age;
  Map<String, String> info = {};

  Animals(this.species, this.age, this.info);

  String get introduce {
    return '$species ${this.info.toString()}';
  }

  void doSport() {
    print('--- $species do sport');
  }

  void doEat() {
    print('--- $species eat some');
  }
}

class MonekyHou extends Animals {

  int sex = 0;

  // 重写属性
  String get species => '灵长类动物';

  @override
  String get introduce => '子类重写父类的 实例方法';

  /* https://dart.cn/language/constructors#constructor-inheritance
   * 
   * 1、子类使用 super 调用父类的构造函数
   * 子类不会从它的父类继承构造函数，如果一个类没有声明构造函数，那么它只能使用默认构造函数。
   * 子类可以调用其父类的构造函数来初始化实例。
   * 
   * Dart按照以下顺序执行构造函数:
   *  1、initializer list 初始化器列表
   *  2、调用父类的未命名、无参数构造函数，如果没有则调用父类的其它构造函数。
   *  3、主类的无参数构造函数
   * 
   * 子类中调用父类的构造函数中不能访问this。
   */

  MonekyHou(int sex, String species, int age, Map<String, String> info) : super(species, age, info) {
    this.sex = sex;
  }


  /* 2、super 参数
   * 
   * 为了避免将每个参数传递给 super构造函数 调用，可以使用 super.params 的方式将参数转发给指定的或默认的 父类构造函数。
   * super.params 不能用于指定初始化器。并且适用于 Dart 2.17+。
   * 
   */
  MonekyHou.from(super.species, super.age, super.info, this.sex);



  void doSport() {
    super.doSport();
    print('$species 喜欢爬树');
  }

  @override
  void doEat() {
    print('$species 喜欢吃香蕉');
  }
}

void testExtensClass() {
  var moneky = MonekyHou(2, '孙猴子', 5, {'address': '花果山', 'nickname': '猴子猴孙'});
  print('species = ${moneky.species}, introduce = ${moneky.introduce}');    // 打印：pecies = 灵长类动物, introduce = 子类重写父类的 实例方法

  print('--- do sport');
  moneky.doSport();
  print('--- do eat');
  moneky.doEat();

  var moneky2 = MonekyHou.from('猴狲', 2, {'name': '小猴子'}, 1);
  print('--- moneky2 = ${moneky2.introduce}');
}

/*
 * extends 还可以用于泛型，使用 extends 实现参数类型的限制。
 */
class Foo<T extends Animals> {
  String toString() => "Instance of 'Foo<$T>'";
}
