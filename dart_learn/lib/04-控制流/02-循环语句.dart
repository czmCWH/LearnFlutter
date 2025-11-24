/*
 *  https://dart.cn/language/patterns
 *  https://dart.cn/language/loops
 * 
 */

void main(List<String> args) {
  testForLoops();

  testWhileLoops();

  testLoopsSuspend();
}

void testForLoops() {
  print('------ 1、for 循环语句：');

  // 1、for 基本使用
  var message = StringBuffer('Dart is fun');
  for (var i = 0; i < 5; i++) {
    message.write('!');
  }
  print('message = ${ message.toString() }');    // 打印：message = Dart is fun!!!!!
  
  // 2、⚠️ for循环内部的闭包会捕获索引的值
  var callbacks = [];
  for (var i = 0; i < 2; i++) {
    // callbacks.add(() {
    //   print('for 循环的索引i = $i ');
    // });

    callbacks.add(() => print('for 循环的索引i = $i '));
  }

  for (final c in callbacks) {
    c();    // 打印：0，1
  }

  // 3、for循环迭代 可迭代类型(List、Set)，⚠️ 此处用 final 
  var list1 = ['a', 'b', 'c'];
  for (final item in list1) {
    print('--- item = $item');    // 打印：a、b、c
  }

  var set1 = {1, 2, 3};
  for (final st in set1) {
    print('--- set = $st');    // 打印：1、2、3
  }
}

void testWhileLoops() {
  print('------ 2、while 循环语句：');
  var w = 3;
  while (w > 0) {
    w--;
    print('--- w = $w');    // 打印：2、1、0
  }


  print('--- do while 循环语句：');
  var doW = 0;
  do {
    doW++;
    print('--- doW = $doW');
  } while (doW < 3);    // 打印：1、2、3
}

void testLoopsSuspend() {
  print('------ 3、break 和 continue');

  // 如果循环条件一直满足，循环体将一直执行，这样就产生了死循环。
  // 可以在循环体内使用 break 或者 continue 停止循环。

  // break：终止整个循环，代码循环后面执行
  for (var i = 0; i < 5; i++) {   // 打印：0、1、2
    if (i == 3) {
      break;
    }
    print('---i = $i');
  }

  // continue：暂停本次迭代，直接进入下一次迭代
  for (var j = 0; j < 5; j++) {   //0、1、2、4
    if (j == 3) {
      continue;
    }
    print('---i = $j');
  }
}