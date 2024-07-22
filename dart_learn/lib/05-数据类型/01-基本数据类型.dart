// https://dart.cn/language/built-in-types
/*
1、Dart语言对以下各项具有特殊支持：
  Numbers (int, double)
  Strings (String)
  Booleans (bool)
  Records ((value1, value2))
  Lists (List, also known as arrays)
  Sets (Set)
  Maps (Map)
  Runes (Runes; often replaced by the characters API)
  Symbols (Symbol)
  空值null (Null) 

  `Dart`支持使用`literal`(字面量)创建对象的能力。如，`"a string"`是`string literal`，而`true`是`boolean literal`。
*/

void main() {
  // testNumbers();
  testStrings();
}

void testNumbers() {
  /*
   * 如果 num 及其子类型没有您要查找的内容，则 dart:math 库可能有。
   * import 'dart:math';
   */

  print('使用 Dart 数字类型: int 和 double');
  
  // 没有小数点的数字类型是 int。整数值不大于64位，具体取值范围 依赖于不同的平台。整数就是不带小数点的数字，如下：
  var x = 1;
  var hex = 0xeeeeee;
  print('x = $x, ${x.runtimeType}。hex = $hex, ${hex.runtimeType}');   // 打印：1 15658734

  // 如果数字包含小数，则它是 double。
  var y = -1.1;
  var exponents = 1.42e5;
  print('y = $y, ${y.runtimeType} 。 exponents = $exponents, ${exponents.runtimeType}');   // 打印：1.1 , 142000

  print('绝对值：${y.abs()}');
  print('把 double 转 int : ${y.toInt()}');

  // int 和 double 都是 num 的子类型
  // https://dart.cn/guides/language/numbers
  // 将变量声明为 num，变量可以同时具有整数值和双数值。
  num j = 1;
  j += 2.5;
  print('num 类型: j = $j, ${j.runtimeType}');

  // String 和 int、double 的相互转换
  // String -> int
  var sInt = int.parse('10');
  // int -> String
  var iStr = 10.toString();

  // String -> double
  var sDouble = double.parse('1.23');

  // double -> String
  var dStr = 1.2233.toString();
  var dPonitStr = 1.2233.toStringAsFixed(2);
  print('sInt = $sInt, iStr = $iStr, sDouble = $sDouble, dStr = $dStr, dPonitStr = $dPonitStr \n');

}

void testStrings() {
  print('使用 Dart 字符串类型: String');

  // Dart字符串（即String对象）包含一系列UTF-16代码单元。可以使用 单引号 或 双引号 创建一个字符串

  /** 
   * 1、插值表达式，用于在字符串中插入值：
   *    $identifier：把 identifier 标识符的值插入字符串中。
   *    ${expression} ：把 表达式expression 返回的值插入字符串中。
   */

  var s1 = "string string";
  String s2 = 'string string';
  var text = 'text is $s1, ${s2.toUpperCase()}';
  print('定义字符串变量，使用插值表达式: $text');   // 打印：text is string string, STRING STRING

  /**
   * 2、字符串拼接
   *    使用并列放置多个字符串字面量；
   *    `+`运算符；
   */
  var c1 = 'a'"B"'c';
  var c2 = '1'
          "22"
          '333';
  var c3 = c1 + c2;
  print('字符串拼接: c1 = $c1, c2 = $c2, c3 = $c3');

  /**
   * 3、多行字符串
   * 使用带 单引号或双引号的 三引号来创建多行字符串。
   */
  var m1 = """
  山前明月光，
  疑是地上霜。
  """;
  var m2 = '''
  举头望明月，    
  低头思故乡。
  ''';
  print('多行字符串: $m1 $m2');
  
  /**
   * 4、禁止字符串转义
   * 通过添加 r 前缀来创建“原始”字符串
   */
  var r = r'aaa \n bbb';
  print('禁止字符串转义: r = $r');    // 打印：r = aaa \n bbb

  /**
   * 5、获取字符串的长度
   */
  var l = '开心😄下雨☔️';
  print('字符串长度, string.length = ${l.length}, .runes.length = ${l.runes.length} \n');   //  string.length = 8, .runes.length = 7

  // 6、字符串截取
  String rangStr = '你好世界！';
  print('从索引1开始到索引3的字符: ${rangStr.substring(1, 3)}');    // 打印：好世
  print('获取指定字符串位置: ${rangStr.indexOf('世界')}');     // 打印：2

}

void textBooleans() {
  // Dart 使用 bool 关键字表示布尔类型。布尔类型只有2种对象表示：true 和 false，它们都是`compile-time constants`(编译时常量)。
  // Dart 是 type safety(类型安全的)，因此不允许使用 if (nonbooleanValue) 或 assert (nonbooleanValue) 这样的代码检查布尔值，需要显示地检查布尔值。
  var b1 = false;
  if (!b1) {
    print('b1不是true');
  }

  bool b2 = true;
  print('b2 的类型为: ${b2.runtimeType} \n');
}





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

