/* 
 <https://dart.cn/language/class-modifiers>
 <https://dart.ac.cn/language/class-modifiers>
参考博客：https://juejin.cn/post/7233403727755673661

 1、类的修饰符
  ⚠️ 在 Class modifiers 中除了 abstract 外，其它在 Dart 3.0+。
  ⚠️ 类修饰符 用于限制 类 或 mixin 如何使用。

 修饰符关键字位于 class 或 mixin 声明之前。可以出现在 class 声明之前的一整套修饰符包括：
    abstract
    base
    final
    interface
    sealed
    mixin，用于在不使用传统继承的情况下，向类中添加新的功能。
 
 只有 base 修饰符可以出现在 mixin 声明之前。这些修饰符不适用于其他声明，如 enum、typedef、extension 或 extension type。
 
 要允许不受限制地从任何库构造或子类型化权限，请使用不带修饰符的 类 或 mixin 声明。默认情况下，您可以：
    构造类的新实例。
    扩展类以创建新的子类型。
    实现类或 mixin 的接口。
    混入 mixin 或 mixin 类。


 总结：
  1、abstract class：强制子类实现抽象方法；不能被实例化；只能被 extends 继承;
  2、base class：只能被继承，不允许被 implements 实现；可以被实例化；
  3、interface class：只能被 implements 实现；其所有成员属性必须被重写；可以被实例化；
  4、final class：不允许直接继承，被继承的类需使用 base、final 或 sealed；
  5、sealed class：密封类的子类型集是已知的、可枚举的；密封类默认是抽象类；
  
 */