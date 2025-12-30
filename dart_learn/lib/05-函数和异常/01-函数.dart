/* 
  https://dart.cn/language/functions

  Dart 是面向对象语言，即使函数也是对象，其类型为 Function。这意味着函数可以分配给变量，也可以作为参数传递给其他函数。 
  Dart 中函数是一级对象。函数是代码组合和复用的核心单元。
  
  有返回值函数：
    [返回类型] 函数名称(参数) {
      函数体
    }
   函数返回值类型可以省略，Dart会自动推断类型为dynamic。
  
  无返回值函数：
    void 函数名称(参数) {
      函数体
    }
   如果函数没有返回值，函数体最后一行会被隐式的添加 `return null;` 语句。


 */

import 'dart:async';

import 'package:dart_learn/09-%E5%B9%B6%E5%8F%91/02-Future.dart';

// main 一个特殊且 必须的 顶级函数，即程序的入口函数，`Dart` 应用程序总是会从该函数开始执行。
void main(List<String> args) {
  assert(foo() == null);
  var res = addInt2(10, 28);
  print('--- res = $res');

  print('\n----------------------');

  var ppRes = testPositionalParam('a b c', null, ['A', 'B', "C"]);
  print('使用必要位置参数 ppRes = $ppRes');   // ppRes = a b c + null + [A, B, C]

  var npRes = testNamedParam('使用命名参数：', param2: 'hello', param1: 100);
  print('使用命名参数 npRes = $npRes'); // npRes = 100 hello [1, 2, 3]

  var oppRes = testOptionalPositionParam('abc', ' 你好 ', [11, 22]);
  print('使用 可选位置参数 oppRes = $oppRes');    // 打印： ooppRes = abc 你好 [11, 22]

  print('\n----------------------');
  useAnonymous();
}

// ---------------------------- 1、定义函数
int addInt(int a, int b) {
  return a + b;
}

// 省略函数返回值
addInt2(int a, int b) {
  return a + b;
}

// 无返回值函数，当函数返回值类型为 void 时，定义函数时可以省略返回值类型
foo() {
  print('a + b = ${addInt(1, 2)}');
}

/*
  对于只包含一个表达式的函数，可以使用简写语法(箭头语法)：
  在 `=>` 与 `;` 之间的只能是 表达式 而非 语句。比如不能将一个 if语句 放在其中，但是可以放置 条件表达式。
 */
int addInt3(int a, int b) => a + b;



// ---------------------------- 2、函数的参数
/*
  2.1、required positional parameters(必要位置参数)
   语法： [void] 函数名(type name1, type name2, …)
   特点：⚠️ 
      调用时按顺序传入对应数量和类型的实参，不需要写参数名。
      必要位置参数不允许设置默认值。
      可以是 nullable 类型（如 int?），但仍需显式传 null。
      必须出现在参数列表最前面。
      必要位置参数 后面可以跟 named parameters 或 可选位置参数，但不能同时跟随这两种。
   应用场景：

  
  2.2、named parameters（命名参数）-------- 使用最多！
   语法：[void] 函数名({type name1, type name2, …})
   特点：⚠️ 
      命名参数用大括号包裹。
      调用时实参的传递依赖于参数名（即：参数名:值），而不是参数的顺序。
      命名参数如果没有 明确标记为 required 或者 提供默认值，否则它的类型必须可以为 null；
      命名参数的默认值必须是 compile-time constant；
   应用场景：参数多，且需明确含义时。
 */

String testPositionalParam(String param1, int? param2, List<String> param3) {
  return '$param1 + $param2 + $param3';
}

String testNamedParam(String name, {int? param1, required String param2, List<int> param3 = const [1, 2, 3]}) {
  print(name);
  return '$param1 $param2 $param3';
}

/* 
 2.3、optional positional parameters（可选位置参数）
 语法：
     [void] 函数名([type name1, type name2, …])

 特点：⚠️ 
   可选位置参数用中括号包裹。
   调用时实参的传递按照顺序传递，不需要写参数名。
   如果给 可选位置参数 不提供默认值，则它们的类型必须可为 null。
   可选位置参数的默认值必须是 compile-time constant。
   可选位置参数 必须位于 必要位置参数 后面。

 应用场景：参数少，且顺序固定。
 */

String testOptionalPositionParam(String positionParam, [String? param1, List<int> param2 = const [1, 2, 3]]) {
  return positionParam + (param1 ?? '未传递参数') + param2.toString();
}


// ---------------------------- 3、匿名函数
/* 
  Dart 中可以创建一个没有名字的方法，称之为 匿名函数(anonymous function)、 Lambda表达式 或 Closure闭包。
  匿名函数可以赋值给一个变量，通过变量名进行调用。
  匿名函数可以作为其它函数的参数。

  语法：
      [Function|var] 变量名 = ([[Type] param1[, …]]) { 
         // 函数主体
      }; 
  
 */

void useAnonymous() {
  print('--- 定义匿名函数：');
  Function val = (bool res, String msg) {
      return res ? msg : 'aaa';
  };
  print(val(true, "用变量名调用匿名函数"));

  print('--- 匿名函数作为参数：');

  // 通过变量传递匿名函数
  var val2 = (int a, int b) {
    return a*b;
  };
  testMath(val2);

  // 直接传递匿名函数参数
  testMath((a, b) {
    return a + b;
  });

  print('--- 如下, map、forEach 接收匿名函数作为参数:');
  const list = ['apples', 'bananas', 'oranges'];
  list.map((item) {
    return item.toUpperCase();
  }).forEach((item) {
    print('$item: ${item.length}');
  });

  var list2 = ['A', 'B', "C"];
  list2.forEach(printForItem);  

  var funcEl = <T>(T param) => print('-- 函数作为变量: $param');
  list2.forEach(funcEl);   

}
// 定义函数类型别名
typedef MathOperation = int Function(int a, int b);

void testMath(MathOperation callback) {
  var res = callback(10, 20);
  print('接收函数类型的参数：res = $res');
}

void printForItem<T>(T param) {
  print('---打印：$param');
}


// ---------------------------- 4、闭包
/* 
  1、Lexical scope 词法作用域
   Dart 是一种 lexically scoped (词法作用域)的语言，这意味着变量的范围是静态确定的，仅由代码的布局决定。
   可以 `按照大括号向外` 来查看变量是否在范围内。

  2、Lexical closures 词法闭包
   closure(闭包) 是一个函数对象，它可以访问其词法范围内的变量，即使函数是在其原始范围之外使用的。
   
   函数可以封闭定义到它作用域内的变量。在下面的示例中，makeAdd 返回的函数会捕获变量 addBy。 无论返回的函数到哪里，它都会记住`addBy`。
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



// ---------------------------- 5、Generators 生成器函数
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


/* 
 6、external 外部函数

  外部函数是指其函数体与其声明分开实现的函数。
   语法：
      1、声明：
        external 【返回值类型】 函数名(【参数】);
      2、实现：
      > 函数实现部分可来自另一个 Dart 库；
      > 函数实现来自另一种语言，external引入了外部函数或值的类型信息，使它们在Dart中可用。
   
   外部函数可以是顶级函数、实例方法、 getter 或 setter 或非重定向构造函数
   
*/
