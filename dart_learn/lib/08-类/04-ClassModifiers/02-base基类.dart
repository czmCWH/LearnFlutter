/* https://dart.cn/language/class-modifiers#base
 * 
 * 1、base 修饰符
 * 要强制继承类或mixin的实现，请使用 base 修饰符。
 * 
 * base class 不允许在自己的库之外实现。这保证：
 *    每当创建类的子类型的实例时，都会调用 base class 的构造函数。
 *    所有实现的私有成员都存在于子类型中。
 *    base class 中新实现的成员不会破坏子类型，因为所有子类型都继承新成员。除非子类型已经声明了具有相同名称和不兼容签名的成员，否则情况确实如此。
 * 
 * 必须把任何一个 implements 或 extends 是基类的类标记为base、final 或者 sealed。这可以防止外部库破坏基类的保证。
 * 
 *  
 */

base class Vehicle {
  void moveForward(int meters) {
    // ...
  }
}

// Can be constructed.
Vehicle myVehicle = Vehicle();

// Can be extended.
base class Car extends Vehicle {
  int passengers = 4;
  // ...
}

// ERROR: Can't be implemented.
base class MockVehicle implements Vehicle {
  @override
  void moveForward() {
    // ...
  }
}