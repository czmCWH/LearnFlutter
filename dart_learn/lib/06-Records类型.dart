

void testRecords() {
  /**
   * Records(记录) 类型是 Dart 3.0+ 推出的类型。
   * 
   * 1、概念
   * Records(记录) 是一种匿名的、不可变的聚合类型。
   * 与其他集合类型一样，它们允许您将多个对象绑定到一个对象中。与其他集合类型不同，记录是固定大小的、异构的(多种类型组成的)和类型化的。
   * 
   * 2、声明 Records(记录)类型的 语法：
   * 
   */
  
  // 2.1、Records表达式 是以逗号分隔的 字段名 或 位置字段列表，并用括号括起来。x
  var record = ('value1', a: 2, res: false, 'valu2');
  print('Records表达式: $record, ${record.runtimeType}');      // 打印：(value1, valu2, a: 2, res: false), (String, String, {int a, bool res})

  // 2.2 Records类型注释 是用逗号分隔的类型列表，这些类型包含在括号中。
  // 可以使用 Records类型注释 来定义返回类型和参数类型。

  (int, int) swap1((int, int) record) {
    var (a, b) = record;
    return (b, a);
  }
  print(' Records类型注释: ${swap1((11, 22))}');   // 打印：(22, 11)

  (String, int) r2;
  r2 = ('A string', 123);
  print('使用 Records类型注释 声明变量，并用 Records表达式 初始化: $r2');    // 打印： (A string, 123)

  /**
   * 2.3、Records记录的 命名字段(named fields) x
   * 在 Records类型注释 中，命名字段(named fields) 位于所有位置字段之后，位于类型和名称对的大括号分隔部分内。
   * 在 Records表达式 中，名称位于每个字段值之前，后面有一个冒号：
   */ 
  (int, {double d, bool b}) r3;
  r3 = (10, d: 3.13, b: false);
  print('Records记录的 命名字段: $r3');   // 打印：(10, b: false, d: 3.13)


}

