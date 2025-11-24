/* 
 
 <https://dart.cn/language/class-modifiers#final>

 1、final class 关闭类
  final class 关闭该类的继承体系，被 final 修饰的类无法被直接继承。

 2、final class 包含了 base class 的效果
  final class 可以在同一个库中扩展或实现。final 修饰符包含了 base 的效果，因此任何子类也必须标记为 base、final 或 sealed。
 
 3、final class 应用场景
   - 工具类，不希望任何人继承或伪造这个工具类。
   - 数据模型，确保外部无法创建“看起来像但逻辑不同”的对象。
   - 性能敏感类，编译器可以对 final class 做更强的优化。

 */

void main(List<String> args) {
  
}

final class User {
  final String id;
  final String name;
  final String email;

  User(this.id, this.name, this.email) {
    if (email.isEmpty || !email.contains('@')) {
      throw ArgumentError('Invalid email');
    }
  }

  @override
  bool operator ==(Object other) =>
      other is User && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// 报错！
// class Worker extends User {

// }

final class Employee extends User {
  Employee(super.id, super.name, super.email);
  
}