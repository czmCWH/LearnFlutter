/* extends 继承
 * 
 * Dart 使用 extends 来创建子类，使用 super 来引用父类。
 * extends 还可以用于泛型。
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

  MonekyHou(int sex, String species, int age, Map<String, String> info) : super(species, age, info) {
    this.sex = sex;
  }

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
}