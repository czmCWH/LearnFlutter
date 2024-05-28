/*

dart 操作符: https://dart.cn/language/operators


 */


void testMathOperators() {
  print('---算术运算符：');

  print(2 + 3);       // 加法：5
  print(5 / 2);       // 除法：2.5
  print(5 ~/ 2);      // 除法 取整：2
  print(5 % 2);       // 取余：1

  // Dart 还支持前缀和后缀，自增和自减运算符。
  var a = 10;
  var b = a++;
    
  var a2 = 10;
  var b2 = ++a2;
    
  print('b = $b, b2 = $b2');    // b = 10, b2 = 11

}

void testRelationalOperators() {
  print('---相等和关系运算符：');

  print(' 2 == 2: ${ 2 == 2 }');    // true

  var a = 2;
  var b = 2;
  print(' a 和 b 是否是完全相同的对象: ${ identical(a, b) }');    // true

  print(' 2 >= 2 : ${ 2 >= 2 }');   // 2 >= 2 : true
  
  print(' 2 <= 2 : ${ 2 <= 2 }');   // 2 <= 2 : true

}

void testTypeOperators() {
  print('---类型运算符：');

  // as， is， 和 is! 运算符用于在运行时处理类型检查。
  /*
   * as：当且仅当确定对象属于特定类型时，使用 as 将对象强制转换为该类型。  
   * is：如果您不确定该对象是否属于 T 类型，请在使用该对象之前使用 is T 检查类型。
   * is!：如果对象是指定类型则返回 false。
   */  

  Object a = [1, 2, 3, 4];
  print(a is List);     // true
  print(a is! List);    // false
  print((a as List<int>).length);     // 4
  

}

void testAssignmentOperators() {
  print('---赋值运算符：');
  
  /*  
   * = 运算符 用于分配值；
   * ??= 当被赋值的变量为null时，才会给它赋值。
   */

  var a = 100;
  int? b = 10;

  b ??= a;
  print(b);   // 10
    
  b = null;     // 只有当b为null时，才会进行赋值
  b ??= a;
  print(b);   // 100
  
  // 其它复合赋值运算符：+=、-=、*=、/=

}

void testLogicalOperators() {
  print('---逻辑运算符：');
  
  /* 1、逻辑运算符
   * !expr  取反表达式；
   *  ||  逻辑或
   *  &&  逻辑与
   */

}

void testConditionalExpr() {
  print('---条件表达式：');

  /* Dart 有两个运算符，有时可以替换 if-else 表达式，让表达式更简洁：
   * 1、condition ? expr1 : expr2
   * 
   * 2、expr1 ?? expr2    如果 expr1 为非null，则返回其值；否则，计算并返回 expr2 的值。??又称为空合并运算符。
   *  
   */

  String? str = '123';
  str = null;
  print('str = ${ str ?? 'str 没有值'}');   // 打印：str = str 没有值

}

void testCascadeOperations() {
  print('--- 级联运算符：');
  
  /* 
   * 级联（..，？..）允许对同一对象进行一系列操作。
   * 除了访问实例成员之外，还可以调用同一对象上的实例方法。这通常可以省去创建临时变量的步骤，并允许您编写更流畅的代码。
   * 
   * 严格来说，级联的`..`符号不是运算符。 它只是`Dart`语法的一部分。
   */



  /*
   * 如果级联操作的对象可以为 `null`，则对于第一个操作，请使用一个 null短路级联(?..)。 
   * 以 ?.. 开头的内容可保证不会对该空对象尝试任何级联操作。?.. 是 dart 2.12 版本引入的。 
   */

  /*
   * 注意：必须在返回实际对象的函数上构造级联。否则会报错。
   */

}

void testSpreadOperations() {
  print('--- 展开运算符：');

  /*
   * 展开运算符( ... or ...? )对 返回集合的表达式 计算，对结果值进行解包，然后将它们插入到另一个集合中。
   * 
   * 展开运算符实际上并不是一个运算符表达式。其语法是集合字面量本身的一部分。
   * 因为它不是运算符，所以没有任何运算符优先级，而是最低优先级。
   */
  var arr1 = [1, 2, 3];
  var arr2 = [4,5,6, ...arr1];
  print('arr = $arr2');   // 打印：arr = [4, 5, 6, 1, 2, 3]

  Set<int>? set1 = null;
  Set<int> set2 = {2, 3, 5, ...?set1};
  print('set = $set2');   // 打印：set = {2, 3, 5}


}

void testOtherOperations() {
  print('--- 其它运算符：');
  
  /*
   * .  运算符，用于引用表达式的属性，例如：foo.bar从表达式foo中选择属性
   * ?.  运算符，类似于 `.`运算符，但其最左边的操作数可以为`null`，若为 `null` 则返回 `null`
   * !  运算符，将表达式转换为其底层不可为空的类型，如果转换失败则抛出运行时异常。
   * ?[] 条件下标访问运算符，不知道如何使用！！！！！！！！！！！！！！！！
   */

  // List<int> arr1 = [1, 2, 3];
  // var num = arr1?[3];
  // print('arr1[0] = ${arr1[0]}, arr1[3] = $num');

// Map<String, int> scores = {'Alice': 90, 'Bob': 80};
// String name = 'Charlie';
// int score = scores?[name]; // 使用 ?[] 运算符
// print(score); // 输出：null

}