
/* 
 1、终值 (final) 和常量 (const)
  语法： 
     [final | const] 类型注释 变量名 = 值/表达式;    
  
  2、特点
  一个 final 变量只能设置一次，即运行时常量，值在运行时确定后不可改变；const 变量是 compile-time constants(编译时常量)。
  const 常量隐式包含了 final。
  ⚠️ final 声明的对象不能被修改，但它的字段可能可以被更改。相比之下，const 对象及其字段不能被更改。
  
  3、应用场景
    final 应用场景：
      声明一个常量；
      实例变量 可以是 final 但不能是 const；
  
    const 使用场景：
      声明一个常量；
      创建常量值，该常量值可以赋予给任何变量，包括 final。
      如果 const 变量位于类级别，请将其标记为 static const（静态常量）。
      使用 const 声明 创建(create) 常量值的构造函数，这种类型的构造函数创建的对象是不可改变的。
 */

// main 一个特殊且 必须的 顶级函数，即程序的入口函数，`Dart` 应用程序总是会从该函数开始执行。
void main(List<String> args) {

  /*
    final 运行时常量
   */

  final name = 'Bob'; 
  final String nickName = '小哈';
  final time = DateTime.now();
  print("声明 final 终值 name = $name, nickName = $nickName, time = $time");  // name = Bob, nickName = 小哈, time = 2025-11-04 14:39:02.474307

  // final 可以通过计算/函数动态获取值（即运行时能确定的值）
  final myName = getName();
  print("myName = $myName");  // myName = lxf
  var n = 10;
  final n1 = 10 + n;
  print("n1 = $n1");  // n1 = 20


  print("--------------------------");

  /*
    const 编译时常量
   */

  const i = 3;
  const double atm = 1.01325 * i;
  print("const 声明常量, i = $i,  atm = $atm");

  // ⚠️，声明 const 时，必须赋值，接收一个常量值（即编译期间就确定的值）
  // const myName = getName(); // 报错！因为，getName() 是运行时才能确定结果的函数调用。
  var count = 10;
  // const count1 = 10 + count; // 报错！因为，是使用var声明的变量，其值可能在运行时改变。
  const count2 = i + 10;  // const 声明常量时，接收表达式里不允许有变量。
  print("count2 = $count2");

  var arr1 = const [12];
  arr1 = [23, 3];
  print("使用 const 创建常量值, 并赋值给一个变量, arr1 = $arr1");
  
  
  print("--------------------------");

  final foo = const [12];
  print("把 const 创建的常量赋值给 final 声明的常量, foo = $foo");
  
  // 可以省略以 const 声明变量的值的 const 修饰
  const baz = [2];   // 等价于 const [2]
}

String getName() {
  return 'lxf';
}