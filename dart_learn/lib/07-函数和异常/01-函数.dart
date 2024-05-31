/* https://dart.cn/language/functions
 * 
 * Dart 是面向对象语言，即使函数也是对象，其类型为 Function。这意味着函数可以分配给变量，也可以作为参数传递给其他函数。
 * 
 * Dart 中函数是一级对象。
 * 
 */

// 1、定义函数
// 所有函数都会返回一个值。如果没有明确指定返回值，函数体最后一行会被隐式的添加 `return null;` 语句。

import 'dart:async';

int addInt(int a, int b) {
  return a + b;
}

foo() {
  print('a + b = ${addInt(1, 2)}');
}

// assert(foo() == null);

// 对于只包含一个表达式的函数，可以使用简写语法(箭头语法)：
// 在 `=>` 与 `;` 之间的只能是 表达式 而非 语句。比如不能将一个 if语句 放在其中，但是可以放置 条件表达式。
int addInt2(int a, int b) => a + b;






//  2、函数的参数

/* 2.1、required positional parameters(必要位置参数)
 * 语法：
 *      [void] 函数名(param1, param2, …)
 * 
 * 必要位置参数 后面可以跟 named parameters 或 可选位置参数，但不能同时跟随这两种。
 * 
 */


/*  
 * 2.2、named parameters（命名参数）
 * 语法：
 *     [void] 函数名({param1, param2, …})
 * 
 * 命名参数如果没有 明确标记为 required 或者 提供默认值，则它的类型必须可为 null；
 * 给命名参数的默认值必须是 compile-time constant；
 */

void testNamedParam({int? param1, required String param2, List<int> param3 = const [1, 2, 3]}) {
  print('$param1 $param2 $param3');
}

void useTestNamedParam() {
  print('--- 命名参数：');
  testNamedParam(param1: 100, param2: 'hello');
}

/* 
 * 2.3、optional positional parameters（可选位置参数）
 * 语法：
 *     [void] 函数名([param1, param2, …])
 * 
 * 如果给 可选位置参数 不提供默认值，则它们的类型必须可为 null。
 * 可选位置参数 的默认值，必须是 compile-time constant；
 * 
 */

String testOptionalPositionParam(String positionParam, [String? param1, List<int> param2 = const [1, 2, 3]]) {
  return positionParam + (param1 ?? '未传递参数') + param2.toString();
}

void useTestOptionalPositionParam() {
  print('--- 可选位置参数');
  var res = testOptionalPositionParam('abc');
  print('res = $res');    // 打印： res = abc未传递参数[1, 2, 3]
}



// 3、函数作为参数

void printForItem<T>(T param) {
  print('---打印：$param');
}

void UsePrintForItem() {
  print('--- 函数作为另一个函数的参数，函数分配给变量：');

  var list = ['A', 'B', "C"];
  list.forEach(printForItem);     

  var funcEl = <T>(T param) => print('-- 函数作为变量: $param');
  list.forEach(funcEl);     
}


// 4、匿名函数

/* Dart 中可以创建一个没有名字的方法，称之为 匿名函数(anonymous function)、 Lambda表达式 或 Closure闭包。
 * 
 * 语法：
 *    ([[Type] param1[, …]]) { 
 *        // 函数主体
 *     }; 
 * 
 */

void useAnonymous() {
  print('--- 匿名函数：');
  var val = (bool res, String msg) {
      return res ? msg : 'aaa';
  };
  print(val(true, "用变量接收匿名函数"));

  // 如下：map、forEach 接收匿名函数作为参数
  const list = ['apples', 'bananas', 'oranges'];
  list.map((item) {
    return item.toUpperCase();
  }).forEach((item) {
    print('$item: ${item.length}');
  });
}



// 5、Lexical scope 词法作用域

/* 
 * Dart 是一种 lexically scoped (词法作用域)的语言，这意味着变量的范围是静态确定的，仅由代码的布局决定。
 * 可以 `按照大括号向外` 来查看变量是否在范围内。
 * 
 */



// 6、Lexical closures 词法闭包

/* 
 * closure(闭包) 是一个函数对象，它可以访问其词法范围内的变量，即使函数是在其原始范围之外使用的。
 * 
 * 函数可以封闭定义到它作用域内的变量。在下面的示例中，makeAdd 返回的函数会捕获变量 addBy。 无论返回的函数到哪里，它都会记住`addBy`。
 */

Function makeAdd(num addBy) {
  return (num i) => addBy + i;
}

void testClosure() {
  print('--- 闭包词法：');

  var add1 = makeAdd(2);

  var add2 = makeAdd(4);

  print(add1(10));    // 打印：12
  print(add2(20));    // 打印：24
}



// 7、Generators 生成器函数
/*
 * 当需要延迟生成一系列值时，请考虑使用生成器函数。Dart 内置了对两种生成器函数的支持：
 *  
 * Synchronous generator（同步生成器）：返回一个 Iterable 对象。
 * Asynchronous generator（异步生成器）：返回一个 Stream 对象。
 *  
 */

// 要实现同步生成器函数，请将函数体标记为 sync*，并使用 yield 语句传递值：
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}
void usSyncGenerator() {
  print('--- 使用同步生成器函数：');

  Iterable<int> iterable = naturalsTo(10);
  print('---- iterable = $iterable');     // 打印：iterable = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
}

// 要实现异步生成器函数，请将函数体标记为 async*，并使用 yield 语句传递值：

Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}

// 如果你的生成器是递归的，你可以通过使用yield*来提高它的性能：
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}



