/* 空安全 Null safety

 * Dart 语言要求以健全(可靠)的空安全方式编写代码。空安全将潜在的 运行时错误 转变为 编辑时 分析错误。
 *
 *  Nullable type(可空类型)
 * Non-nullable type (非可空类型)
 */

void testNull() {
  print("定义变量类型为 Nullable type(可空类型): ");

  // 1、在为变量、参数或组件制定类型时，在类型声明的末尾添加 ?，表示该类型可以为null，其默认值为null。
  String? name;
  // Nullable type(可空类型) 的默认值为 null。
  print('name = $name');
  name = '你好';
  print('name = $name');

  // 2、Dart 不会为 Non-nullable type(非可空类型) 设置初始值，必须在使用变量之前对其进行初始化。
  var age;
  print("未对 Non-nullable type 设置初始值，访问即报错：$age");

  // 3、不能在 Nullable type(可空类型) 的表达式上访问属性或调用方法。同样的例外情况适用于 null 支持的属性或方法，例如 hashCode 或 toString() 。
}
