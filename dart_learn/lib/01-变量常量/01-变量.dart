/*
 * 学习博客：https://dart.cn/language/variables
 */


// main 一个特殊且 必须的 顶级函数，即程序的入口函数，`Dart` 应用程序总是会从该函数开始执行。
void main(List<String> args) {
  // 1、字符串插值
  int num = 100;
  print('字符串插值：${num}');
  
  print('Hello world: ${calculate()}!');

  print('--------------------------');

  /*
    2、var 声明变量
    变量仅存储对象的引用；
    var 声明变量时，给定初始值，Dart 会进行类型推断出该变量的类型。⚠️ 建议局部变量用 var 声明；

    语法：
      var 变量名 = 值/表达式
    
    runtimeType 用于获取变量当前类型；
   */

  // name 变量包含一个值为 "Bob" 的 String 对象的引用。
  var a = '张三';
  print("var a = $a, a 的类型为：${a.runtimeType}");  // var a = 张三, a 的类型为：String

  // 使用 var 定义变量，不给定初始值，其类型为最后一次给定的值的类型确定。
  var a1;
  a1 = "hello";
  a1 = 100;
  a1 = "你好";
  print("var a1 = $a1, a1 类型为：${a1.runtimeType}\n");  // var a1 = 100, a1 类型为：int

  var a2 = 100;
  // a2 = "abc";  // 报错！⚠️，var 声明变量时，给定了初始值，后面不允许更改其类型。

  print('--------------------------');

  /*
    3、使用准确的类型显式声明变量
      使用类型注释声明变量，声明之后该变量的类型不可改变。
   */
  double n = 3.7;
  print("double n = $n"); // double n = 3.7

  // 不必在声明变量时初始化变量，但在使用之前需要为其赋值。
  int n1;
  n1 = 22;
  print("int n1 = $n1 \n"); // int n1 = 22 

  print('--------------------------');

  // 4、Object 变量
  Object obj = "abc";
  obj = 100; 
  print("Object obj = $obj");   // Object obj = 100
  obj = "abc";
  print("Object obj = $obj");   // Object obj = abc

  print('--------------------------');

  // 5、dynamic 变量
  dynamic dy = 100;
  dy = "abc";
  print("dynamic dy = $dy");  // dynamic dy = abc
  dy = 100;
  print("dynamic dy = $dy\n");  // dynamic dy = 100

  print('--------------------------');

  /*
    6、延迟初始化变量
     语法：late 变量类型 变量名;
     
     late 修饰符有两种用法：
      1、声明一个非空变量，但不在声明时初始化。
      2、延迟初始化一个变量。
     
     应用场景：
       Dart 推断）可能不需要该变量，并且初始化它的开销很高。
       在初始化一个实例变量，它的初始化方法需要调用 this。

     ⚠️ 顶级变量 和 类变量 是延迟初始化的，它们会在第一次被使用时再初始化。
   */

  // 如果声明变量时没有初始化变量，但你确定变量在使用之前已设置，但 Dart 推断错误的话，可以将变量标记为 late 来解决这个问题：
  late int score;
  score = 20;
  print(score);

  late var number;
  number = 3.1415926;
  print(number);

  // int name = calculate();
  late int name1 = calculate();

}

int calculate() {
  print("--- calculate 调用了");
  return 6 * 7;
}