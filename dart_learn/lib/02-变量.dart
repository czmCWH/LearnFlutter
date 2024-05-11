/*
 * 学习博客：https://dart.cn/language/variables
 */

int calculate() {
  return 6 * 7;
}

/* 1、字符串插值
 * 
 */
void testPrint(int num) {
  print('Hello world: ${calculate()}!');
  print("==czm==$num");
}

/* 2、定义变量
 * 变量仅存储对象的引用。
 * 由于类型推断，`Dart` 建议局部变量用 `var` 声明。
 * `runtimeType`：用于获取变量当前类型。
 */
void testVar() {
  // 使用 var 定义变量，Dart 会进行类型推断。
  // name 变量包含一个值为 "Bob" 的 String 对象的引用。
  var name = 'Bob';
  print("获取当前变量的类型：${name.runtimeType}");

  // 通过类型注释，显式声明将要推断的类型
  double antennaDiameter = 3.7;

  // 不必在声明变量时初始化变量，但在使用之前需要为其赋值。
  // 顶级变量和类变量是延迟初始化的，它们会在第一次被使用时再初始化。
  int count;
  count = 22;
  print("count = $count");
}

/* 3、空安全 Null safety
 * Dart 语言要求以健全(可靠)的空安全方式编写代码。空安全将潜在的 运行时错误 转变为 编辑时 分析错误。
 * 空安全能够防止意外访问 null 的变量而导致的错误。这样的错误也被称为空解引用错误。访问一个求值为 null 的表达式的属性或调用方法时，会发生空解引用错误。
 * Dart 编译器可以在空安全的基础上在编译期检测到这些潜在的错误。
 */

void testNull() {
  // 空安全引入了三个关键更改：
  // 1、当为变量、参数或另一个相关组件指定类型时，可以添加 ? 控制该类型是否允许 null 。
  // Nullable type(可空类型) 的默认值为 null。
  String? name;
  print('name = $name');
  name = '你好';
  print('name = $name');

  // 2、必须在使用变量之前对其进行初始化。Dart 不会为 Non-nullable type(非可空类型) 设置初始值，它强制要求你设置初始值。  
  var age;
  print(age);

  // 3、不能在 Nullable type(可空类型) 的表达式上访问属性或调用方法。同样的例外情况适用于 null 支持的属性或方法，例如 hashCode 或 toString() 。
}

/* 4、延迟初始化变量
 * late 修饰符有两种用法：
 *    1、声明一个非空变量，但不在声明时初始化。
 *    2、延迟初始化一个变量。
 */
void testLate() {

// 如果声明变量时没有初始化变量，但你确定变量在使用之前已设置，但 Dart 推断错误的话，可以将变量标记为 late 来解决这个问题：
late int score;
score = 20;
print(score);

// late 延迟初始化一个变量。适用场景：
// （Dart 推断）可能不需要该变量，并且初始化它的开销很高。
//  在初始化一个实例变量，它的初始化方法需要调用 this。
late String name = "可能是通过方法返回值获取";

}


/* 5、终值 (final) 和常量 (const)
 *  如果不打算更改一个变量，可以使用 final 或 const 替代 var 修饰它，或放在类型注释的后面。
 * 一个 final 变量只能设置一次，const 变量是 compile-time constants(编译时常量)。const 常量隐式包含了 final。
 * 
 * 实例变量 可以是 final 但不能是 const。
 * 如果 const 变量位于类级别，请将其标记为 static const（静态常量）。
 * 
 * const 关键字不仅用于声明常量，还可以使用它来创建 常量值，该常量值可以赋予给任何变量。
 * 
 * 还可以声明 创建(create) 常量值的构造函数，这种类型的构造函数创建的对象是不可改变的。
 */

void testFixVar() {

  final name = 'Bob'; 

  // const 修饰 编译时常量 的变量。
  final String nickname = '小哈';

  const Object i = 3;

  /*
    `const` : 必须赋值，接收一个常量值（即编译期间就需要确定的值）
    `final` : 可以通过计算/函数动态获取值（即运行时能确定的值）
  */
  final myName = getName();
// const myName = getName(); // 报错

  
  // foo 变量拥有一个常量值，但是 foo 依然可以被修改。
  var foo1 = const [12];
  final foo2 = const [12];

  // final 变量bar拥有常量值
  final bar = const [];
  
  // 可以省略以 const 声明中的值的 const 修饰
  const baz = [2];   // 等价于 const [2]
}

String getName() {
  return 'lxf';
}