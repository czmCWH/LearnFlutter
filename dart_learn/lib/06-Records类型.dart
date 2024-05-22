void testRecords() {
  /**
   * Records(记录) 类型是 Dart 3.0+ 推出的类型。
   * 
   * 1、概念
   * Records(记录) 是一种匿名的、不可变的 聚合类型(aggregate type)。
   * 与其他 集合类型(collection types) 一样，它们允许您将多个对象绑定到一个对象中。
   * 与其他 集合类型 不同，Records(记录)是固定大小的、异构的(多种类型组成的)和类型化的。
   * 
   * 2、声明 Records(记录)类型的 语法：
   * 
   */
  
  // 2.1、Records表达式 是以逗号分隔的 命名字段(named fields) 或 位置字段(positional fields) 列表，并用括号括起来。
  var r1 = ('value1', a: 2, res: false, 'valu2');
  print('Records表达式: $r1, ${r1.runtimeType}');      // 打印：(value1, valu2, a: 2, res: false), (String, String, {int a, bool res})

  // 2.2、Records(记录)类型注释 是用逗号分隔的类型列表，这些类型包含在括号中。
  // Records类型注释 来定义函数返回类型和参数类型。
  (int, int) swap1((int, int) record) {
    var (a, b) = record;
    return (b, a);
  }
  print(' Records类型注释: ${swap1((11, 22))}');   // 打印：(22, 11)

  // 使用 Records(记录)类型注释 声明r2变量；
  (String, int) r2;
  // Records表达式初始化
  r2 = ('A string', 123);
  print("r2 = $r2, ${r2.runtimeType}");

  /**
   * 3、Records(记录)类型 的 命名字段(named fields) 和 位置字段(positional fields)
   * 
   *  在 Records类型注释 中，命名字段(named fields) 位于所有 位置字段(positional fields) 之后, 位于【type-name对】的大括号分隔部分内。
   *  在 Records表达式 中，名称 放在每个 字段值之前，后面有一个冒号。
   *  位置字段(positional fields) 是有顺序的，命名字段(named fields)是没有顺序的
   */  

  (int, {double d, bool b}) r3;
  r3 = (10, d: 3.13, b: false);
  print('$r3, ${r3.runtimeType}');   // 打印：(10, b: false, d: 3.13)

  // 具有不同名称的 命名字段(named fields) 的两个 Records(记录) 具有不同的类型
  ({int a, int b}) rAB = (a: 1, b: 2);
  ({int x, int y}) rXY = (x: 3, y: 4);
  print('rAB == rXY: ${ rAB == rXY}');  // rAB == rXY: false

  // Records(记录)类型注释 中，可以命名位置字段，这些命名纯粹用于注释文档，不会影响其类型是位置字段。
  (int x, int y) rVale = (3, 4);
  print('rXY type = ${rXY.runtimeType}, rVale type = ${rVale.runtimeType} \n');  // rXY type = ({int x, int y}), rVale type = (int, int)
  
}

void testUseRecords() {

  print('使用Records记录类型: ');

  // 1、访问 Records(记录)类型 中存储的数据
  /**
   * 位置字段 暴露了名称 $<position> 的getter，跳过了命名字段。
   * 字段没有setter，不能单独修改 Records(记录)类型 的某一个字段。
   */
  var r1 = ('first', a: 2, b: true, 'last', false);
  print(r1.$1);
  print(r1.a);
  print(r1.b);
  print(r1.$2);
  print(r1.$3);

  // r1 = ('一', true, '二', a: 10, b: false);    // 报错，类型不同。
  r1 = ('一', '二', true, a: 10, b: false);
  print(r1.$1);
  print(r1.a);
  print(r1.b);
  print(r1.$2);

  // 如下会报错
  // r1.$1 = "哈哈";

  /**
   * 2、判断 Records(记录) 变量是否相等
   * 两个 Records(记录) 具有相同的字段类型，
   */

  (String, bool, {int a, int b}) r2 = ('您好', true, a: 10, b: 20);
  (String, bool, {int b, int a}) r3 = ('您好', true, b: 20, a: 10);
  
  (String, bool, {int b, int a}) r4 = ('您好', true, b: 10, a: 20);
  (String, bool, {int b, int a}) r5 = ('您好', b: 10, a: 20, true);
  print('r2 == r3: ${ r2 == r3}');    //  r2 == r3: true
  print('r2 == r4: ${ r2 == r4}');    //  r2 == r4: false
  print('r2 == r5: ${ r2 == r5}');    //  r2 == r5: false
  
  print("r2 type = ${r2.runtimeType}");   // r2 type = (String, bool, {int a, int b})
  print("r3 type = ${r3.runtimeType}");   // r3 type = (String, bool, {int a, int b})
  print("r4 type = ${r4.runtimeType}");   // r4 type = (String, bool, {int a, int b})
  print("r5 type = ${r5.runtimeType} \n");   // r5 type = (String, bool, {int a, int b})
}