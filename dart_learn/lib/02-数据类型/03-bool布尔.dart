void main(List<String> args) {
  /*
    bool 关键字表示布尔类型。
    bool 类型只有2种对象表示：true 和 false，它们都是`compile-time constants`(编译时常量)。

    Dart 是 type safety(类型安全的)，因此不允许使用 if (nonbooleanValue) 或 assert (nonbooleanValue) 这样的代码检查布尔值，需要显示地检查布尔值。
   */
  var b1 = false;
  if (!b1) {
    print('b1不是true');
  }

  bool b2 = true;
  print('b2 的类型为: ${b2.runtimeType} \n');
}
