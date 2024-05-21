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
  print("字符串差值的使用：$num\n");
}

/* 2、使用 var 创建变量
 * 变量仅存储对象的引用。
 * 由于类型推断，`Dart` 建议局部变量用 `var` 声明。
 * `runtimeType`：用于获取变量当前类型。
 */
void testVar() {
  print("2、使用var关键字定义变量: ");
  /**
   * 1、使用 var 定义变量时，给定初始值，Dart 会进行类型推断出该变量的类型。
   * 如下：name 变量包含一个值为 "Bob" 的 String 对象的引用。
   */
  var name = '张三';
  print("var name = $name, name 的类型为：${name.runtimeType}");

  /**
   * 2、使用 var 定义变量，不给定初始值，其类型为最后一次给定的值的类型确定。
   */
  var a;
  a = "hello";
  a = 100;
  print("var a = $a, a 类型为：${a.runtimeType}\n");
}

/* 3、使用准确的类型显式声明变量
 */
void testExplicitlyVar() {
  print("3、使用准确的类型显式定义变量：");

  // 使用类型注释声明变量，声明之后该变量的类型不可改变。
  double num = 3.7;
  print("double num = $num");

  // 不必在声明变量时初始化变量，但在使用之前需要为其赋值。
  int count;
  count = 22;
  print("int count = $count\n");
} 
/* 4、Object 变量
 * 
 */
void testObjectVar() {
  print("4、使用 Object 定义变量：");
  Object a = "abc";
  a = 1223; 
  print("Object a = $a");
  a = "abc";
  print("Object a = $a\n");
}

/* 5、dynamic 变量
 * 
 */
void testDynamicVar() {
  print("5、使用 dynamic 定义变量：");
  dynamic b = 100;
  b = "abc";
  print("dynamic b = $b");
  b = 100;
  print("dynamic b = $b\n");
}


/* 6、延迟初始化变量
 * 
 * 语法：
 *    late 变量类型 变量名;
 * 
 * late 修饰符有两种用法：
 *    1、声明一个非空变量，但不在声明时初始化。
 *    2、延迟初始化一个变量。
 * 
 * 顶级变量和类变量是延迟初始化的，它们会在第一次被使用时再初始化。
 */
void testLate() {
  print("6、late 延迟初始化变量: ");

  // 如果声明变量时没有初始化变量，但你确定变量在使用之前已设置，但 Dart 推断错误的话，可以将变量标记为 late 来解决这个问题：
  late int score;
  score = 20;
  print(score);

  late var num;
  num = 3.1415926;
  print(num);

  // late 延迟初始化一个变量。适用场景：
  // （Dart 推断）可能不需要该变量，并且初始化它的开销很高。
  //  在初始化一个实例变量，它的初始化方法需要调用 this。
  late String name = "可能是通过方法返回值获取";
  
}