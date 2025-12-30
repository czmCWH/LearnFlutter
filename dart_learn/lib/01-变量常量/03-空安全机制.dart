/* 
  <https://dart.cn/null-safety>，健全的空安全

 1、Dart 空安全（Null safety）

  Dart 语言要求以健全(可靠)的空安全方式编写代码。空安全 会在编译期防止意外访问 null 变量的错误的产生。
    
  空安全版本支持：
    Dart 2.12 之前的 SDK 版本不提供空安全。
    Dart 2.12 到 2.19 中，包含的 dart migrate 工具支持迁移代码至空安全。即 Flutter 2.0.0～3.7.0 版本。
    Dart 3 开始，内置了可靠的空安全机制，Dart 3 会阻止缺少该机制的代码运行。即 Flutter 3.10.0+ 版本。
  
  空安全的优点：
    - 以将原本运行时的空值引用错误将变为编辑时的分析错误;
    - 增强程序的健壮性，有效避免由Null而导致的崩溃;


  Nullable type(可空类型)
  Non-nullable type (非可空类型)

 2、使用空安全
   有了空安全后，`?.、!、late` 会大量应用。

 */

// main 一个特殊且 必须的 顶级函数，即程序的入口函数，`Dart` 应用程序总是会从该函数开始执行。
void main(List<String> args) {

  // 1、定义变量类型为 Nullable type(可空类型) `类型?`
  // 在为变量、参数或组件制定类型时，在类型声明的末尾添加 ?，表示该类型可以为null，其默认值为null。
  String? name;
  // Nullable type(可空类型) 的默认值为 null。
  print('name = $name');  // null
  name = '你好';
  print('name = $name');  // 你好

  // 2、Dart 不会为 Non-nullable type(非可空类型) 设置初始值，必须在使用变量之前对其进行初始化。
  // var age;
  // print("未对 Non-nullable type 设置初始值，访问即报错：$age");

  
  // 2、安全访问 `?.`，是指访问对象为 null 时跳过操作，返回null
  String? str;
  print('str.length = ${str?.length}');   // str.length = null

  // 3、非空断言 `!.`，将表达式转换为其底层不可为空的类型，如果转换失败则抛出运行时异常。
  str = '张三';
  print('-- ${str!.startsWith('张')}'); // -- true

  // 4、空合并 `a ?? b`，左侧 a 为 null 时，返回 右侧 b 的默认值
  str = null;
  print('str = ${str ?? '默认值'}');  // str = 默认值

  // 5、延迟初始化(late)
  // 对于无法在定义时进行初始化，并且又想避免使用?.，那么可以通过late修饰的变量，
  late int count;
  count = 20;
  print("-- count = $count");

}
