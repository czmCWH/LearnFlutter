
/* 终值 (final) 和常量 (const)
 *  
 * 语法： 
 *    1、final 或 const 替代 var；
 *    2、[final | const] 类型注释 变量名 = value;
 *    3、 const 变量位于类级别：static const（静态常量）;
 * 
 * 一个 final 变量只能设置一次，const 变量是 compile-time constants(编译时常量)。
 * const 常量隐式包含了 final。
 * 
 * final 使用场景：
 *    1、声明一个常量；
 *    2、实例变量 可以是 final 但不能是 const。
 * 
 * const 使用场景：
 *    1、声明一个常量；
 *    2、创建常量值，该常量值可以赋予给任何变量。
 *    3、如果 const 变量位于类级别，请将其标记为 static const（静态常量）。
 *    4、使用 const 声明 创建(create) 常量值的构造函数，这种类型的构造函数创建的对象是不可改变的。
 * 
 * `final` : 可以通过计算/函数动态获取值（即运行时能确定的值）
 * `const` : 必须赋值，接收一个常量值（即编译期间就需要确定的值）
 * final 声明的对象不能被修改，但它的字段可能可以被更改。相比之下，const 对象及其字段不能被更改。
 */

void testFixVar() {


  final name = 'Bob'; 
  final String nickName = '小哈';
  //  可以通过计算/函数动态获取值（即运行时能确定的值）
  final myName = getName();
  print("1、使用 final 声明常量, name = $name, nickName = $nickName, myName = $myName");

  const i = 3;
  const double atm = 1.01325 * i;
  // const myName = getName(); // 报错
  print("2、使用 const 声明常量, i = $i,  atm = $atm");

  var arr1 = const [12];
  arr1 = [23, 3];
  print("3、使用const 创建常量值, 并赋值给一个变量, arr1 = $arr1");
  
  final foo = const [12];
  print("4、把 const 创建的常量赋值给 final 声明的常量, foo = $foo");
  
  // 可以省略以 const 声明中的值的 const 修饰
  const baz = [2];   // 等价于 const [2]
}

String getName() {
  return 'lxf';
}