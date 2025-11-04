// https://dart.cn/language/built-in-types

/*
1、Dart语言对以下各项具有特殊支持：
  数字 (int, double)
  字符串 (String)
  布尔 (bool)
  Lists 列表 (List)
  Records 记录 ((value1, value2))
  Sets 集合 (Set)
  Maps 字典 (Map)
  Runes (Runes; often replaced by the characters API)
  Symbols (Symbol)
  空值null (Null) 

  Dart 支持使用 literal(字面量)创建对象的能力。如，`"a string"`是`string literal`，而`true`是`boolean literal`。
*/


/*
2、其他一些类型在 Dart 语言中也具有特殊作用：
  Object: 是除 Null 外的所有`Dart`类的父类。
  Enum: 所有枚举的父类。
  Future 和 Stream: 用于异步支持。
  Iterable: 用于 for-in 循环和 同步生成器函数(synchronous generator functions)。
  Never: 指示表达式永远无法成功完成计算。最常用于总是抛出异常的函数。
  dynamic: 指示禁用静态检查，将类型检查推迟到运行时。通常应该使用`Object` 或 `Object?`代替。
  void: 表示该值永远不会被使用。通常用作返回类型。

 */

