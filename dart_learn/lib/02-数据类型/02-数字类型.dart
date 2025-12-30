void main(List<String> args) {
  /*
    Dart 中的数字类型：num、int、double。 
     int，整数，整数值不大于64位，具体取值范围 依赖于不同的平台。
     double，小数。
     num，可整数可小数，它是 int 和 double 的父类。

    使用 var 声明变量时，如果没有小数点，则为 int，否则为 double。
    如果 num 及其子类型没有您要查找的内容，则 dart:math 库可能有。即，import 'dart:math';
   */

  var x = 1;
  var x1 = 1.0;
  print("x = $x, ${x.runtimeType}; x1 = $x1, ${x1.runtimeType}");   // x = 1, int; x1 = 1.0, double
  var hex = 0xeeeeee;
  print('hex = $hex, ${hex.runtimeType}');   // 打印：1 15658734

  var exponents = 1.42e5;
  print('exponents = $exponents, ${exponents.runtimeType}');   // 打印：exponents = 142000.0, double

  double y = -1.53;
  print('绝对值：${y.abs()}');
  print('把 double 转 int : ${y.toInt()}'); // -1，⚠️，直接截取转换

  print("-----------------------------");

  num j = 1;
  j += 2.5;
  print('num 类型: j = $j, ${j.runtimeType}');

  print("-----------------------------");

  // String 和 int、double 的相互转换
  // String -> int
  var sInt = int.parse('10');
  // int -> String
  var iStr = 10.toString();

  print('sInt = $sInt, iStr = $iStr');

  // String -> double
  var sDouble = double.parse('1.23');

  // double -> String
  var dStr = 1.2233.toString();
  var dPonitStr = 1.2263.toStringAsFixed(2); // ⚠️，会进行四舍五入
  print('sDouble = $sDouble, dStr = $dStr, dPonitStr = $dPonitStr');  // sDouble = 1.23, dStr = 1.2233, dPonitStr = 1.23

}