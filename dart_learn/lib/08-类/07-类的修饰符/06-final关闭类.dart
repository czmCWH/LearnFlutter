/* 
 
 <https://dart.cn/language/class-modifiers#final>

 1、final 关闭类
 要关闭类型层次结构，请使用final修饰符。这可以【防止从当前库之外】的类进行子类型化。
 final class 同时不允许继承 和 实现，可以完全阻止子类型化。这保证：
    可以安全地向API添加增量更改。
    可以调用实例方法，并且知道它们没有在第三方子类中被覆盖。
 
 final class 可以在同一个库中扩展或实现。final 修饰符包含了 bas e的效果，因此任何子类也必须标记为 base、final 或 sealed。
 
  
 */

