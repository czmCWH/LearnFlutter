/* https://dart.cn/language/mixins
 *
 *  mixin类声明要求 Dart3.0+。 早期版本中的代码通常使用 abstract class 代替。 
 * 
 * 1、mixins 混入
 * mixin 是定义可以在多个类层次结构中重用代码的一种方式。它们旨在集体提供成员实现。
 * 
 * 要定义 mixin，请使用 mixin 声明。在需要同时定义 mixin 和 类的极少数情况下，可以使用 mixin class 声明。
 * 要使用 mixin，使用 with 关键字，后跟一个或多个 mixin 名称。
 * 
 * mixin 和 mixin class 不能有 extends子句，也不能声明任何生成构造函数。
 * 
 * 2、指定mixin可以调用自己的成员
 * 
 * 3、mixin 中实现 interface
 * 与声明 mixin抽象 类似，在 mixin 上放置 implements子句，而不实际实现接口，也将确保为 mixin 定义任何成员依赖。
 * 
 * 4、使用on子句声明 mixin 父类
 * on子句 的存在是为了定义解析超调用的类型。所以，只有当你需要在 mixin 中有一个 super 调用时，你才应该使用它。
 * 
 * on子句 强制任何使用mixin的类也成为 on子句 中类型的子类。
 * 
 */

abstract interface class Dog {
  void watchDog();
}

class ArtMajor {
  String name;
  int age;
  List<String> course;

  ArtMajor(this.name, this.age, this.course);

  void studySome() {
    print('美术学主要研究美术学');
  }
}

mixin Painter on ArtMajor {
  bool canPlayPiano = false;

  /* 2.2、在 mixin 子类中的访问状态
   *  声明 抽象成员 还允许您通过调用在 mixin 上定义为抽象的 getter 来访问 mixin 的子类上的状态：
   */
  String get isStandard => canPlayPiano ? '是一个合格的画家' : '不是一个合格的画家';

  void playPainter() {
    super.studySome();
    print('画家喜欢画画');
  }

  /* 2.1、在mixin中定义抽象成员
   *  在 mixin 中声明 abstract(抽象)方法 会强制任何使用 mixin的类型 定义 其行为所依赖的抽象方法。
   */
  void defineAbstractFunc();

}

mixin Calligrapher implements Dog {
  bool canCalligrapher = true;

  void playCalligrapher() {
    watchDog();
    print('书法家喜欢书写\n');
  } 
}

class Artist extends ArtMajor with Painter, Calligrapher {
  
  List<String> works;

  Artist(this.works, super.name, super.age, super.course);

  void defineAbstractFunc() {
    print('实现 Painter mixins 中定义的抽象方法');
  }

  void watchDog() {
    print('狗子看着门');
  }
}


void testMixins() {

  var p = Artist(['和平鸽'], '毕加索', 80, ['素描']);
  p.playCalligrapher();
  p.playPainter();
  p.defineAbstractFunc();

  print('-- isStandard = ${p.isStandard}');
}


/* 
 * 5、mixin 类型 和 mixin class 类型
 * 
 * mixin 声明定义了一个 mixin。
 * mixin class 声明定义了一个既可用作常规类又可用作 mixin 的类，具有相同的名称和类型。
 * 
 * 任何适用于 class 或 mixin 的限制也适用于 mixin class:
 *  mixin 不能有 extends 或 with子句，所以 mixin class 也不能。
 *  class 不能有 on子句，mixin class 也不能。
 * 
 */

// 定义一个 mixin class
mixin class Teacher {
  // ...
}

// 把 mixin class 作为 mixin 
class MathTeacher with Teacher { 
  // ...
}

// 把 mixin class 作为类继承
class PhysicsTeacher extends Teacher { 
  // ...
}


