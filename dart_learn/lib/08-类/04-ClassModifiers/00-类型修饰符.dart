/* https://dart.cn/language/class-modifiers
 * 
 * 在 Class modifiers 中除了 abstract 外，其它在 Dart 3.0+。
 * 
 * Class modifiers(类修饰符) 控制 类 或 mixin 的使用方式，既可以在其自己的库中使用，也可以在定义它的库外部使用。
 * 修饰符关键字位于类或 mixin 声明之前。可以出现在类声明之前的一整套修饰符包括：
 *    abstract
 *    base
 *    final
 *    interface
 *    sealed
 *    mixin
 * 
 * 只有 base 修饰符可以出现在 mixin 声明之前。修饰符 不适用于枚举、typedef、扩展或扩展类型等其他声明。
 * 
 * 要允许不受限制地从任何库构造或子类型化权限，请使用不带修饰符的类或 mixin 声明。默认情况下，您可以：
 *    构造类的新实例。
 *    扩展类以创建新的子类型。
 *    实现类或 mixin 的接口。
 *    混入 mixin 或 mixin 类。
 * 
 * 
 * 参考博客：https://juejin.cn/post/7233403727755673661?searchId=2024060921224390D8776C97353FDB6DDC#heading-3
 * 
 */