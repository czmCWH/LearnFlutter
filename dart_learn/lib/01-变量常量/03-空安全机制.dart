/* 
 Dart 空安全 Null safety

  Dart 语言要求以健全(可靠)的空安全方式编写代码。空安全将潜在的 运行时错误 转变为 编辑时 分析错误。
  
  Nullable type(可空类型)
  Non-nullable type (非可空类型)
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
}
