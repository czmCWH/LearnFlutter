void main() {
  testObject();
}

/*
1、dynamic 动态类型
 dynamic 用来声明动态类型，允许变量运行时自由改变类型。
  
 dynamic 定义的变量会关闭编译时类型检查，这意味着 dynamic a = 'a'; a.test()，这样的代码静态类型检查不会报错，但是会导致运行时 crash。
 dynamic 是所有 Dart 对象的基础类型，在大多数情况下，通常不直接使用它。
 */
void testDynamic() {
  dynamic b = 100;
  b = "abc";
  print("dynamic b = $b");    // dynamic b = abc
  b = 100;
  print("dynamic b = $b\n");  // dynamic b = 100
}

/*
2、var
 var 是声明变量的关键字，系统会根据初始值自动推断变量类型 runtimeType。
 */
void testVar() {
   var a = 'czm';
   print('系统会根据 a 第一次赋值的类型，来确定它的类型: ${a.runtimeType}');  // 系统会根据 a 第一次赋值的类型，来确定它的类型: String
}

/*
3、Object
Object 是 Dart 对象的基类，它提供了 toString、hashCode等方法。

使用 Object 类型的变量调用不存在的函数时会报错，因为 Object 类型会静态类型检查报错，而 dynamic 类型却不会。
 */
void testObject() {
  Object a = 123455;
  var b = a.toString();
  print('b = $b, ${b.runtimeType}');   // 打印: b = 123455, String
}